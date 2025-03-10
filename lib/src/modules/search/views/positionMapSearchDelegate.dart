// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:position/generated/l10n.dart';
import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/modules/auth/models/user_model/user.dart';
import 'package:position/src/modules/search/bloc/bloc/search_bloc.dart';
import 'package:position/src/modules/search/models/search_result_model/search_model.dart';
import 'package:position/src/modules/search/widgets/positionSearchItem.dart';

class PositionMapSearchDelegate extends SearchDelegate<SearchResultModel> {
  final String? hintText;
  final SearchBloc? searchBloc;
  final User? user;
  PositionMapSearchDelegate(
      {this.hintText, @required this.searchBloc, @required this.user});

  String? queryString;

  @override
  String? get searchFieldLabel => hintText;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme;
  }

  @override
  TextStyle? get searchFieldStyle => const TextStyle(
        fontSize: 14,
        fontFamily: "OpenSans",
      );

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.clear,
          color: primaryColor,
        ),
      ),
      const VerticalDivider(
        color: grey3,
      ),
      InkWell(
        highlightColor: transparent,
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 10),
          height: 20,
          width: 40,
          child: SvgPicture.asset("assets/images/svg/icon-perm_identity.svg"),
        ),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, SearchResultModel());
      },
      icon: const Icon(
        Icons.arrow_back,
        color: primaryColor,
      ),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    queryString = query;
    return const Scaffold();
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    queryString = query;
    if (query.length >= 2) {
      searchBloc!.add(MakeSearch(query, user));
    }
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading && query.isNotEmpty) {
          return const Center(
            child: SpinKitPulse(
              color: primaryColor,
              size: 60.0,
            ),
          );
        }
        if (state is SearchError) {
          return Center(
            child: Text(PositionLocalizations.of(context).searcherror),
          );
        }
        if (state is SearchLoaded) {
          if (state.searchresult!.isEmpty) {
            return Center(
              child: Text(PositionLocalizations.of(context).searchnotfound),
            );
          }

          return ListView.builder(
            itemCount: state.searchresult!.length,
            itemBuilder: (context, index) {
              return InkWell(
                  highlightColor: transparent,
                  onTap: () {
                    close(context, state.searchresult![index]);
                  },
                  child: PositionSearchItem(
                      searchResultModel: state.searchresult![index]));
            },
          );
        }
        return const Scaffold();
      },
    );
  }
}
