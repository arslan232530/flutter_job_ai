import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:job_board/controllers/appstarter/starter_provider.dart';
import 'package:job_board/controllers/auth/login/login_provider.dart';
//import 'package:job_board/helper/starter_listener.dart';
import 'package:job_board/views/drawer_main.dart';
import 'package:job_board/views/homepage.dart';
import 'package:job_board/views/main_screen.dart';
import 'package:job_board/views/ui/auth/login.dart';
import 'package:job_board/views/ui/auth/personal_details.dart';
import 'package:job_board/views/ui/auth/signup.dart';
import 'package:job_board/views/ui/bookmark/bookmark_screen.dart';
import 'package:job_board/views/ui/chat/chat_list.dart';
import 'package:job_board/views/ui/chat/chatpage.dart';
import 'package:job_board/views/ui/devicemanagement/device_manage.dart';
import 'package:job_board/views/ui/jobs/jobs_page.dart';
import 'package:job_board/views/ui/onboarding/onboarding_screen.dart';
import 'package:job_board/views/ui/profile/profile_screen.dart';
import 'package:job_board/views/ui/search/search_screen.dart';
import 'package:job_board/views/ui/appearence/appearence.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // final starterNotifier = ref.read(starterProvider.notifier);
  ref.watch(starterProvider);
  ref.watch(loginProvider.select((s) => s.loggedIn));
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final seen = ref.read(starterProvider).seen;
      final loggedIn = ref.read(loginProvider).loggedIn;

      final goingToOnboarding = state.matchedLocation == '/onboarding';
      final goingToLogin = state.matchedLocation == '/login';
      final goingToRoot = state.matchedLocation == '/';

      if (goingToRoot) {
        if (!seen) return '/onboarding';
        if (!loggedIn) return '/login';
        if (loggedIn) return '/drawermain';
      }

      if (seen && goingToOnboarding) {
        return loggedIn ? '/drawermain' : '/login';
      }

      if (loggedIn && goingToLogin) {
        return '/drawermain';
      }

      // // Handle initial route
      // if (goingToRoot) {
      //   if (!seen) return '/onboarding';
      //   if (!loggedIn) return '/login';
      //   if (ref.read(loginProvider).firstTime) return '/personal-details';
      //   return '/drawermain';
      // }
      // // Prevent accessing onboarding if already seen
      // if (seen && goingToOnboarding) {
      //   return loggedIn ? '/drawermain' : '/login';
      // }

      // if (loggedIn && !firstTime && goingToLogin) {
      //   return '/drawermain';
      // }

      // if (!loggedIn && (goingToSignup || goingToLogin || goingToRoot)) {
      //   return null; // allow /signup or /login
      // }

      // //  Prevent accessing main routes if not seen
      // if (!seen && !goingToOnboarding && !goingToRoot) {
      //   return '/onboarding';
      // }

      // if (loggedIn && firstTime && goingToLogin) {
      //   return '/personal-details';
      // }

      // if (goingToSignup) {
      //   return null;
      // }

      // if (seen && !loggedIn && !goingToLogin) {
      //   return '/login';
      // }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(
        path: '/drawermain',
        builder: (context, state) => const DrawerMain(),
      ),
      GoRoute(
        path: '/personal-details',
        builder: (context, state) => const PersonalDetails(),
      ),
      GoRoute(
        path: '/profilescreen',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: 'bookmark',
        builder: (context, state) => const BookmarkScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/devicemng',
        builder: (context, state) => const DeviceManagement(),
      ),
      GoRoute(
        path: '/mainscreen',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/homescreen',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/themescreen',
        builder: (context, state) => const ThemeScreen(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/chatlist',
        builder: (context, state) => const ChatsList(),
      ),
      GoRoute(
        path: '/jobs',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return JobPage(id: data['id'], title: data['title']);
        },
      ),
      GoRoute(
        path: '/chatpage',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return ChatPage(
            id: data['id'],
            profile: data['profile'],
            title: data['title'],
            user: [data['user1'], data['user2']],
          );
        },
      ),
    ],
  );
});
