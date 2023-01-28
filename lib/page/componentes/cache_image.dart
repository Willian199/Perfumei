import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:util/constantes/Double.dart';

class CacheImagem extends StatelessWidget {
  final String imagemUrl;
  final IconData errorIcon;
  final Widget Function(BuildContext, ImageProvider) imagemBuilder;
  const CacheImagem({
    required this.imagemBuilder,
    required this.imagemUrl,
    this.errorIcon = Icons.error,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      alignment: Alignment.centerLeft,
      child: Center(
        child: CachedNetworkImage(
          imageUrl: imagemUrl,
          imageBuilder: (context, imageProvider) {
            return imagemBuilder(context, imageProvider);
          },
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) {
            return CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: Double.SETENTA,
              foregroundColor: Colors.white,
              child: Icon(
                errorIcon,
                color: Theme.of(context).colorScheme.primary,
                size: Double.SESSENTA,
              ),
            );
          },
        ),
      ),
    );
  }
}
