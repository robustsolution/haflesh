import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:the_hafleh/common/values/supabase.dart';
import 'package:the_hafleh/common/values/colors.dart';
import 'package:the_hafleh/common/values/custom_text_style.dart';
import 'package:the_hafleh/common/utils/images.dart';
import 'package:the_hafleh/common/utils/logger.dart';
import 'package:the_hafleh/common/widgets/static_progress_bar.dart';
import 'package:the_hafleh/common/widgets/button.dart';
import 'package:the_hafleh/core/blocs/profile/profile_bloc.dart';
import 'package:the_hafleh/core/blocs/auth/auth_bloc.dart';
import 'package:the_hafleh/core/models/profile_model.dart';
import 'package:the_hafleh/view/info/widgets/profile_photos.dart';
import 'package:the_hafleh/view/info/widgets/bio_input.dart';
import 'package:the_hafleh/view/info/widgets/prompt/prompt_input.dart';
import 'package:the_hafleh/view/welcome/welcome_done_page.dart';

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
    User? authedUser = FirebaseAuth.instance.currentUser;
    ProfileModel profile = context.read<ProfileBloc>().state.profile;
    // context
    //     .read<ProfileBloc>()
    //     .add(ProfileUpdated(profile.copyWith(uid: authedUser!.uid)));
    context.read<ProfileBloc>();
  }

  Widget _activePage() {
    ProfileModel profile = context.read<ProfileBloc>().state.profile;
    switch (_currentPage) {
      case 0:
        return step1(profile);
      case 1:
        return step2(profile);
      case 2:
        return step3(profile);
      default:
        return step1(profile);
    }
  }

  void createAccount() async {
    try {
      ProfileModel profile = context.read<ProfileBloc>().state.profile;
      User? authedUser = FirebaseAuth.instance.currentUser;
      if (authedUser != null) {
        List<String> photos = ["", "", "", ""];
        for (int i = 0; i < 6; i++) {
          ImageProvider? element = profileImages[i];
          if (element == null) {
            continue;
          }

          Uint8List bytes = await getImageBytes(element);
          final response = await Supabase.instance.client.storage
              .from(SupabaseConsts.photoBucket)
              .uploadBinary("public/${authedUser.uid}_$i.png", bytes,
                  fileOptions: const FileOptions(upsert: true));
          photos[i] = getPublicPhotoUrl(response);
        }
        // ignore: use_build_context_synchronously
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(photos: photos)));
        // ignore: use_build_context_synchronously
        context.read<ProfileBloc>().add(const ProfileCreateRequested());
      }
    } catch (e) {
      logger.e("create account error $e");
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
    context.watch<ProfileBloc>();

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              // if the profile successfully created, show welcome modal
              if (state.status == ProfileStatus.created) {
                // WelcomeDialog.showWelcomeDialog(context, onButtonPressed: () {
                //   context
                //       .read<ProfileBloc>()
                //       .add(// after click ok button, move to main page
                //           ProfileWelcomeClicked());
                // });
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
                                    Theme.of(context).colorScheme.onSecondary)),
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
                              Navigator.of(context)
                                  .push<void>(WelcomeDonePage.route());
                              // createAccount();
                            }
                          })),
                  const SizedBox(width: 24),
                ]),
                const SizedBox(height: 16),
              ],
            )));
  }

  Widget step1(ProfileModel profile) {
    return ProfilePhotos(
        profileImages: profileImages,
        onChange: (value) {
          setState(() {
            profileImages = value;
          });
        });
  }

  Widget step2(ProfileModel profile) {
    return BioInput(
      bio: profile.bio ?? "",
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(bio: value)));
      },
    );
  }

  Widget step3(ProfileModel profile) {
    return PromptInput(
      prompts: profile.prompts ?? ["", "", ""],
      answers: profile.answers ?? ["", "", ""],
      onChangePrompts: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(prompts: value)));
      },
      onChangeAnswers: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(answers: value)));
      },
    );
  }
}
