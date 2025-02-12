import 'package:app_task/src/application/home/home_bloc.dart';
import 'package:app_task/src/application/home/home_state.dart';
import 'package:app_task/src/core/app_constants.dart';
import 'package:app_task/src/domain/database/core/app_database.dart';
import 'package:app_task/src/presentation/core/app_page.dart';
import 'package:app_task/src/presentation/core/base_state.dart';
import 'package:app_task/src/presentation/core/theme/colors.dart';
import 'package:app_task/src/presentation/core/theme/text_styles.dart';
import 'package:app_task/src/presentation/form/form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const route = "/homeState";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  HomeBloc? bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<HomeBloc>(context);
    bloc!.message.listen((value) => showMessage(value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return AppPage(
          title: "Task List",
          isBackButtonRequired: false,
          retryOnTap: () {},
          processStateStream: bloc!.stream.map((state) => state.processState),
          actions: [
            _addTaskButton(context),
          ],
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: Units.kStandardPadding),
            child: _getBodyLayout(context, state),
          ),
        );
      },
    );
  }

  Widget _addTaskButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Units.kSPadding),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, FormPage.route);
        },
        child: Text(
          "Add task",
          style:
              TextStyles.body1Bold(context)!.copyWith(color: AppColors.black),
        ),
      ),
    );
  }

  Widget _getBodyLayout(BuildContext context, HomeState state) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: state.taskList.length,
          itemBuilder: (context, index) {
            final item = state.taskList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Units.kStandardPadding,
              ),
              child: Column(
                children: [
                  _itemLayout(context, item!),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _itemLayout(BuildContext context, TaskList item) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: AppColors.white,
        border: Border.all(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Units.kSPadding),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            _titleTextWithData(context, item),
            const SizedBox(
              height: 30,
            ),
            _completeStatusWithData(context, item),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleTextWithData(BuildContext context, TaskList item) {
    return Row(
      children: [
        Text("Title : ", style: TextStyles.body1BoldMarkdown(context)),
        Expanded(child: Text(item.title, overflow: TextOverflow.visible)),
      ],
    );
  }

  Widget _completeStatusWithData(BuildContext context, TaskList item) {
    return Row(
      children: [
        Text("Complete : ", style: TextStyles.body1BoldMarkdown(context)),
        Text(item.completed.toString()),
      ],
    );
  }
}
