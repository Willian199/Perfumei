import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ddi/flutter_ddi.dart';
import 'package:perfumei/common/components/widgets/slide_animation.dart';
import 'package:perfumei/pages/item/cubit/imagem_cubit.dart';

class ImagemPerfume extends StatefulWidget {
  const ImagemPerfume({this.bytes, super.key});
  final Uint8List? bytes;

  @override
  State<ImagemPerfume> createState() => _ImagemPerfumeState();
}

class _ImagemPerfumeState extends State<ImagemPerfume> with DDIInject<ImagemCubit> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      instance.carregarImagem(widget.bytes);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('building ImagemPerfume');
    return BlocProvider<ImagemCubit>(
      create: (_) => instance,
      child: BlocBuilder<ImagemCubit, bool>(
        builder: (_, __) {
          if (instance.imagem?.isNotEmpty ?? false) {
            return Positioned(
              right: 0,
              top: 30,
              child: SizedBox(
                width: 190,
                child: SlideAnimation(
                  child: Image.memory(
                    instance.imagem!,
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
