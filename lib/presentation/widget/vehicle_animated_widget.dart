import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:slide_animation/extensions.dart';
import 'package:slide_animation/model/car_model.dart';
import 'package:typeset/typeset.dart';

class VehicleAnimatedWidget extends StatefulWidget {
  const VehicleAnimatedWidget({
    super.key,
    required this.carModel,
    required this.onTap,
    this.onScaleUpdate,
    required this.onPinch,
    this.showFAB = true,
  });

  final CarModel carModel;
  final VoidCallback onTap, onPinch;
  final bool showFAB;

  final Function(ScaleUpdateDetails)? onScaleUpdate;

  @override
  State<VehicleAnimatedWidget> createState() => _VehicleAnimatedWidgetState();
}

class _VehicleAnimatedWidgetState extends State<VehicleAnimatedWidget> {
  //
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(top: 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Center(
            child: TypeSet(
              widget.carModel.title?.toUpperCase() ?? '',
              maxLines: 1,
              style: context.textTheme.bodyLarge?.copyWith(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w600,
              ),
            ).padSymmetric(vertical: 10, horizontal: 5),
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                GestureDetector(
                  onScaleUpdate: widget.onScaleUpdate,
                  onTap: widget.onTap,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.asset(
                      widget.carModel.image,
                      fit: BoxFit.cover,
                    ),
                  ).padOnly(left: 10, right: 10, bottom: 15),
                ),

                //
                AnimatedPositioned(
                  duration: 1300.ms,
                  top: widget.showFAB ? context.deviceHeight(0.72) : 25,
                  left: 16,
                  // bottom: widget.showFAB ? 20 : null,
                  width: context.deviceWidth(0.9),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...[
                          TypeSet(
                            widget.carModel.subtitle ?? '',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TypeSet(
                            widget.carModel.description ?? '',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ].fadeInFromLeft()
                      ],
                    ),
                  ),
                ),
                //
                // see more details
                if (widget.showFAB)
                  Positioned(
                    bottom: 20,
                    right: 16,
                    child: FloatingActionButton(
                      shape: const CircleBorder(),
                      onPressed: widget.onPinch,
                      backgroundColor: Colors.white,
                      child: const Center(child: Icon(Icons.table_view_sharp)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
