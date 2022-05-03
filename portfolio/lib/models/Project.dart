class Project {
  final String? title, description, link;

  Project({this.link, this.title, this.description});
}

List<Project> demo_projects = [
  Project(
    title: "SB Diagnostics (Available on Playstore)",
    link: "https://play.google.com/store/apps/details?id=com.mpstechnologies.sbDiagnostics",
    description:
        "An app that allows users to access their test reports and check prices for various diagnostic tests at SB Diagnostics. This app has been designed by me using Figma and developed using Flutter. Now available on the Google Playstore. Kindly use the username \"sample\" and password \"password123\" to get the full app experience without registering yourself at the lab. I use Firebase for the backend and Stripe to process payments.",
  ),
  Project(
    title: "Portfolio WebApp",
    link: "https://github.com/MohanpreetS/projects",
    description:
        "The webapp you are looking at right now. This is responsive and can be displayed on a desktop or mobile phone screen of any size. Feel free to resize your browser to check out the responsiveness!",
  ),
  Project(
    title: "Smart Home App",
    link: "https://github.com/MohanpreetS/projects",
    description:
        "This is a smart hoem app where user cna connect and control smart appliances in theri home rangin from air conditioners to smart lights to smart tvs.",
  ),
  Project(
    title: "Animated Sign up and Login page",
    link: "https://github.com/MohanpreetS/projects",
    description:
        "A small project that showcases an interactive and animated transition between the Sign up and Login pages. It is a small experiment with Flutter animations and an excercise for me to improve my implementation of animations in my apps.",
  ),
  Project(
    title: "Email App",
    link: "https://github.com/MohanpreetS/projects",
    description:
        "A responsive email app UI where the design is inspired from the Outlook app on Mac. The design has been modified to look more minimalist. Since it is responsive, same codebase can be used to render the app on desktop and mobile phone screens of any size.",
  ),
  Project(
    title: "Car Control App UI",
    link: "https://github.com/MohanpreetS/projects",
    description:
        "A relatively unqiue app design inspired by various designs posted on Dribble(a UI showcasing website). This is intended for the user to be able to monitor certain aspects like fuel/battery level, tyre pressure etc. and control things like thermostat temperature and door/boot locks.",
  ),
];
