import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:photo_view/photo_view.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage(
      {super.key,
      required this.imageUrl,
      this.icon,
      this.height = 30,
      this.width = 30,
      this.decoration});

  final String imageUrl;
  final IconData? icon;
  final double? height, width;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      fit: BoxFit.cover,
      imageUrl: imageUrl,
      placeholder: (context, url) => Container(
        decoration: decoration ??
            BoxDecoration(
              color: Colors.grey.withValues( alpha: 0.2),
            ),
        child: Icon(
          icon ?? HugeIcons.strokeRoundedImage02,
          size: (height ?? 30) / 2,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        decoration:
            decoration ?? BoxDecoration(color: Colors.grey.withValues( alpha: 0.2)),
        child: Icon(
          icon ?? HugeIcons.strokeRoundedImage02,
          size: (height ?? 30) / 2,
        ),
      ),
    );
  }
}

class PhotoViewPage extends StatelessWidget {
  final String? imageUrl, imagePath;

  const PhotoViewPage({super.key, this.imageUrl, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 30,),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: const Icon(CupertinoIcons.multiply_circle_fill)),
          ),
          Expanded(
            child: Hero(
              tag: imagePath ?? imageUrl ?? '',
              child: imagePath == null
                  ? PhotoView(
                      imageProvider: NetworkImage(imageUrl!),
                    )
                  : PhotoView(
                      imageProvider: FileImage(File(imagePath!)),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}