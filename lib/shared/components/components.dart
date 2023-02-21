import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:news_app/modules/web_view_screen/web_view_screen.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  String? Function(String?)? onSubmit,
  String? Function(String?)? onChange,
  void Function()? onTap,
  bool isPassword = false,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  void Function()? suffixPressed,
  bool isClickable = true,
  context,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
            width: 2,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
            width: 2,
          ),
        ),
        labelStyle: Theme.of(context).textTheme.bodyText1,
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
      ),
    );

Widget listSeparatorItem() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
        end: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
Widget buildArticleItem(articalItems, context) => InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(
              articalItems['url'],
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                image: DecorationImage(
                  image: NetworkImage('${articalItems['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              // ignore: sized_box_for_whitespace
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${articalItems['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${articalItems['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
          ],
        ),
      ),
    );
Widget conditionBuilderItem(list, {isSearch = false}) =>
    BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => list.length > 0,
          widgetBuilder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildArticleItem(list[index], context),
            separatorBuilder: (context, index) => listSeparatorItem(),
            itemCount: 10,
            physics: const BouncingScrollPhysics(),
          ),
          fallbackBuilder: (context) => isSearch
              ? Container()
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
