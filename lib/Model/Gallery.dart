class Gallery{
  String title;
  String description;
  String imageUrl;
  String galleryId;

  Gallery({this.title, this.description, this.imageUrl, this.galleryId});
}

class GalleryWithReview{
  String title;
  String description;
  String imageUrl;
  double rating;
  int totalUserReview;
  String galleryId;

  GalleryWithReview({this.title, this.description, this.imageUrl, this.rating, this.totalUserReview, this.galleryId});
}

class GalleryData{
  String title;
  String description;
  String imageUrl;

  GalleryData({this.title, this.description, this.imageUrl});
}