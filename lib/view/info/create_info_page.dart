// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hafleh/common/values/custom_text_style.dart';
import 'package:hafleh/common/utils/logger.dart';
import 'package:hafleh/common/widgets/static_progress_bar.dart';
import 'package:hafleh/common/widgets/button.dart';
import 'package:hafleh/core/blocs/info/info_bloc.dart';
import 'package:hafleh/core/blocs/auth/auth_bloc.dart';
import 'package:hafleh/core/blocs/profile/profile_bloc.dart';
import 'package:hafleh/core/models/info_model.dart';
import 'package:hafleh/view/info/widgets/profile_photos.dart';
import 'package:hafleh/view/info/widgets/bio_input.dart';
import 'package:hafleh/view/info/widgets/prompt/prompt_input.dart';
import 'package:hafleh/view/welcome/welcome_done_page.dart';
import 'package:loader_overlay/loader_overlay.dart';

List<String> headings = [
  "Add your videos and photos",
  "Write a short bio about yourself",
  "Write your profile answers",
];

List<String> icons = [
  "gallery.svg",
  "bio.svg",
  "answers.svg",
];

class CreateInfoPage extends StatefulWidget {
  const CreateInfoPage({super.key});

  @override
  _CreateInfoPageState createState() => _CreateInfoPageState();

  static Page<void> page() => const MaterialPage<void>(child: CreateInfoPage());
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const CreateInfoPage());
}

class _CreateInfoPageState extends State<CreateInfoPage> {
  List<ImageProvider?> profileImages = [null, null, null, null, null, null];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<InfoBloc>();
  }

  Widget _activePage() {
    InfoModel info = context.read<InfoBloc>().state.info;
    switch (_currentPage) {
      case 0:
        return step1(info);
      case 1:
        return step2(info);
      case 2:
        return step3(info);
      default:
        return step1(info);
    }
  }

  void createAccount() async {
    try {
      User? authedUser = FirebaseAuth.instance.currentUser;
      InfoModel info = context.read<InfoBloc>().state.info;

      if (authedUser != null) {
        context.read<ProfileBloc>().add(const ProfileCreateRequested());

        List<String> photos = ["", "", "", "", "", ""];
        context
            .read<InfoBloc>()
            .add(InfoUpdated(info.copyWith(photos: photos)));
        context.read<InfoBloc>().add(const InfoCreateRequested());
      }
    } catch (e) {
      logger.e("create error $e");
    }
  }

  void onBackPressed() {
    if (_currentPage == 0) {
      context.read<AuthBloc>().add(SignOutRequested());
    }
    setState(() {
      _currentPage = _currentPage >= 1 ? _currentPage - 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<InfoBloc>();

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, profileState) {
              print("ProfileState ${profileState.status}");
              if (profileState.status == ProfileStatus.createLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
                Navigator.of(context).push<void>(WelcomeDonePage.route());
              }
            },
            child: BlocListener<InfoBloc, InfoState>(
                listener: (context, infoState) {
                  print("InfoState ${infoState.status}");
                  if (infoState.status == InfoStatus.createLoading) {
                    context.loaderOverlay.show();
                  } else {
                    context.loaderOverlay.hide();
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (_currentPage <= 2)
                                  Row(children: <Widget>[
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: StaticProgressBar(
                                          count: 3, current: _currentPage + 1),
                                    ),
                                    const SizedBox(width: 8),
                                  ]),
                                const SizedBox(height: 12),
                                SvgPicture.asset(
                                  "assets/icons/${icons[_currentPage]}",
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(headings[_currentPage],
                                    textAlign: TextAlign.left,
                                    style: CustomTextStyle.getTitleStyle(
                                        Theme.of(context)
                                            .colorScheme
                                            .onSecondary)),
                                const SizedBox(
                                  height: 24,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: _activePage(),
                                  ),
                                )
                              ],
                            ))),
                    Row(children: <Widget>[
                      const SizedBox(width: 24),
                      Expanded(
                          child: Button(
                              title: "BACK",
                              flag: true,
                              outlined: true,
                              onPressed: () {
                                setState(() {
                                  _currentPage--;
                                });
                                if (_currentPage < 0) {
                                  _currentPage = 0;
                                  Navigator.of(context).pop();
                                }
                              })),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Button(
                              title: "NEXT",
                              flag: true,
                              onPressed: () {
                                setState(() {
                                  _currentPage++;
                                });
                                if (_currentPage >= 3) {
                                  _currentPage = 2;
                                  createAccount();
                                }
                              })),
                      const SizedBox(width: 24),
                    ]),
                    const SizedBox(height: 16),
                  ],
                ))));
  }

  Widget step1(InfoModel info) {
    return ProfilePhotos(
        profileImages: profileImages,
        onChange: (value) {
          setState(() {
            profileImages = value;
          });
        });
  }

  Widget step2(InfoModel info) {
    return BioInput(
      bio: info.bio ?? "",
      onChange: (value) {
        context.read<InfoBloc>().add(InfoUpdated(info.copyWith(bio: value)));
      },
    );
  }

  Widget step3(InfoModel info) {
    return PromptInput(
      prompts: info.prompts ?? ["", "", ""],
      answers: info.answers ?? ["", "", ""],
      onChangePrompts: (value) {
        context
            .read<InfoBloc>()
            .add(InfoUpdated(info.copyWith(prompts: value)));
      },
      onChangeAnswers: (value) {
        context
            .read<InfoBloc>()
            .add(InfoUpdated(info.copyWith(answers: value)));
      },
    );
  }
}
