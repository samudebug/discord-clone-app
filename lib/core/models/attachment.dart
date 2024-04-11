enum AttachmentType { IMAGE, VIDEO, FILE, URL }

class Attachment {
  AttachmentType attachmentType;
  String url;

  Attachment(this.attachmentType, this.url);
}

class ImageAttachment extends Attachment {
  ImageAttachment(String url) : super(AttachmentType.IMAGE, url);
}

class VideoAttachment extends Attachment {
  VideoAttachment(String url) : super(AttachmentType.VIDEO, url);
}

class FileAttachment extends Attachment {
  String filename;

  FileAttachment(String url, this.filename) : super(AttachmentType.FILE, url);
}

class URLAttachment extends Attachment {
  String title;
  String subtitle;
  String contentUrl;

  URLAttachment(String url, this.title, this.subtitle, this.contentUrl)
      : super(AttachmentType.URL, url);
}

class AttachmentFactory {
  static Attachment getAttachmentFromJson(Map<String, dynamic> json) {
    AttachmentType type = AttachmentType.values.byName(json['attachmentType']);
    switch (type) {
      case AttachmentType.IMAGE:
        return ImageAttachment(json['url']);
      case AttachmentType.VIDEO:
        return VideoAttachment(json['url']);
      case AttachmentType.FILE:
        return FileAttachment(json['url'], json['filename']);
      case AttachmentType.URL:
        return URLAttachment(
            json['url'], json['title'], json['subtitle'], json['contentUrl']);
    }
  }
}
