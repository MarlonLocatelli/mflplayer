import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:mflplayer/app/data/dao/m3u_item_dao.dart';

@JsonSerializable()
class M3UItem {
  int? id;
  final String name;
  final String url;
  final String tvgName;
  final String tvgLogo;
  final String groupTitle;

  M3UItem({
    this.id,
    required this.name,
    required this.url,
    required this.tvgName,
    required this.tvgLogo,
    required this.groupTitle,
  });


  factory M3UItem.fromJson(Map<String, dynamic> json) {
    return M3UItem(
      id: json[M3UItemDao.columnId],
      name: json[M3UItemDao.columnName] ?? '',
      url: json[M3UItemDao.columnUrl] ?? '',
      tvgName: json[M3UItemDao.columnTvgName] ?? '',
      tvgLogo: json[M3UItemDao.columnTvgLogo] ?? '',
      groupTitle: json[M3UItemDao.columnGroupTitle] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      M3UItemDao.columnId: id,
      M3UItemDao.columnName: name,
      M3UItemDao.columnUrl: url,
      M3UItemDao.columnTvgName: tvgName,
      M3UItemDao.columnTvgLogo: tvgLogo,
      M3UItemDao.columnGroupTitle: groupTitle,
    };
  }

  static List<M3UItem> parseM3U(String m3uContent) {
    final channels = <M3UItem>[];
    final lines = m3uContent.split('\n');
    String? name;
    String? tvgName;
    String? tvgLogo;
    String? groupTitle;
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.startsWith('#EXTINF')) {
        final regex = RegExp(
          r'tvg-name="([^"]+)" tvg-logo="([^"]+)" group-title="([^"]+)",(.+)$',
        );
        final match = regex.firstMatch(line);
        if (match != null) {
          tvgName = match.group(1) ?? '';
          tvgLogo = match.group(2) ?? '';
          groupTitle = match.group(3) ?? '';
          name = match.group(4) ?? '';
        }
        // Verifique se a próxima linha é a URL válida
        if (i + 1 < lines.length) {
          final nextLine = lines[i + 1].trim();
          if (nextLine.isNotEmpty && !nextLine.startsWith('#')) {
            channels.add(
              M3UItem(
                name: name ?? '',
                url: nextLine,
                tvgName: tvgName ?? '',
                tvgLogo: tvgLogo ?? '',
                groupTitle: groupTitle ?? '',
              ),
            );
          }
        }
      }
    }
    return channels;
  }

  static Stream<M3UItem> parseM3UFileAsStream(File file) async* {
    String? name;
    String? tvgName;
    String? tvgLogo;
    String? groupTitle;

    final regExp = RegExp(r'tvg-name="([^"]+)" tvg-logo="([^"]+)" group-title="([^"]+)",(.+)$');
    // Use o método .openRead() que fornece um byte stream
    await for (final line in file.openRead()
        .transform(utf8.decoder)
        .transform(LineSplitter())) {
      final trimmedLine = line.trim();
      if (trimmedLine.startsWith('#EXTINF')) {
        final match = regExp.firstMatch(trimmedLine);
        if (match != null) {
          tvgName = match.group(1) ?? '';
          tvgLogo = match.group(2) ?? '';
          groupTitle = match.group(3) ?? '';
          name = match.group(4) ?? '';
        }
      } else if (trimmedLine.isNotEmpty && !trimmedLine.startsWith('#') && name != null) {
        yield M3UItem(
          name: name,
          url: trimmedLine,
          tvgName: tvgName ?? '',
          tvgLogo: tvgLogo ?? '',
          groupTitle: groupTitle ?? '',
        );
        name = null;
        tvgName = null;
        tvgLogo = null;
        groupTitle = null;
      }
    }
  }
}

