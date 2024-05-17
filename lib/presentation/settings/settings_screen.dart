import 'package:berkania/presentation/settings/settings_cubit.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends CustomState {
  const SettingsScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          switch(state){
            case SettingsCurrentState(): return Center(child: Column(
              children: [
                Text("Settings screen", style: Theme.of(context).textTheme.bodyLarge)
              ],
            ));
            case SettingsLoadingState(): return Center(child: Text("Loading ...", style: Theme.of(context).textTheme.bodyLarge));
            case SettingsErrorState(): return Center(child: Text(state.message, style: Theme.of(context).textTheme.bodyLarge));
          }
        },
      ),
    );
  }
}
