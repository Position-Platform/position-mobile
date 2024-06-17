// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:position/generated/l10n.dart';
import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/modules/search/models/search_result_model/search_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PositionSearchItem extends StatefulWidget {
  const PositionSearchItem({super.key, required this.searchResultModel});
  final SearchResultModel searchResultModel;

  @override
  State<PositionSearchItem> createState() => _PositionSearchItemState();
}

class _PositionSearchItemState extends State<PositionSearchItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.searchResultModel.type == "etablissement"
          ? SizedBox(
              height: double.infinity,
              child: SvgPicture.asset("assets${widget.searchResultModel.logo!}",
                  height: 30, width: 30),
            )
          : widget.searchResultModel.type == "nominatim"
              ? SizedBox(
                  height: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: widget.searchResultModel.logo!,
                    height: 30,
                    width: 30,
                  ),
                )
              : SizedBox(
                  height: double.infinity,
                  child: SvgPicture.network(widget.searchResultModel.logo!,
                      height: 30, width: 30),
                ),
      title: Text(
        widget.searchResultModel.name!,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontFamily: "OpenSans-Bold"),
      ),
      subtitle: Text(widget.searchResultModel.details!,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontFamily: "OpenSans-Bold", color: grey5)),
      isThreeLine: true,
      trailing: widget.searchResultModel.type == "etablissement" &&
              widget.searchResultModel.etablissement!.horaires!.isNotEmpty
          ? widget.searchResultModel.isOpenNow!
              ? Text(PositionLocalizations.of(context).open,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontFamily: "OpenSans-Bold", color: primaryColor))
              : Text(PositionLocalizations.of(context).closed,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontFamily: "OpenSans-Bold", color: redColor))
          : null,
    );
  }
}
