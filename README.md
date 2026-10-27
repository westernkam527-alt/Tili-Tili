# Tili Tili — Flutter project

This is a runnable **starter project** for an India-focused short-video app. It includes a vertical demo video feed, local demo likes/comments/follow state, sharing, Discover tags, Create, Inbox and Profile screens.

## What is not production-ready yet
- Sign-up/login and SMS OTP
- Real video upload, transcoding, cloud storage and persistent feed
- Database-backed users, likes, comments and follows
- Direct messaging and push notifications
- Admin/moderation tools, reporting workflows and privacy/legal pages

Those features need backend services, credentials, security rules and testing. This project does not claim those services are already connected.

## Build APK using only an Android phone and GitHub
1. Download and extract this ZIP.
2. Create a GitHub repository named `tili-tili`.
3. Upload the **contents** of this extracted folder to the repository root, including the hidden `.github` folder.
4. Open **Actions** in the repository. The workflow runs on push to `main`/`master`; you can also run it manually.
5. Open the successful run and download artifact `tili-tili-release-apk`.
6. Extract that artifact and install `app-release.apk`.

## Local build
With Flutter installed:
```bash
flutter pub get
flutter build apk --release
```

APK path: `build/app/outputs/flutter-apk/app-release.apk`

The sample feed uses public demo video URLs and requires internet. Replace them with properly licensed videos before release.
