
import 'package:flutter/material.dart';

Widget bottomBarButton1(context) => IconButton(
  enableFeedback: false,
  onPressed: () => Navigator.pushNamed(context, '/1'),
  icon: const Icon(Icons.home_outlined, color: Colors.white, size: 35),
);

Widget bottomBarButton2(context) => IconButton(
  enableFeedback: false,
  onPressed: () => Navigator.pushNamed(context, '/2'),
  icon: const Icon(Icons.work_outline_outlined, color: Colors.white, size: 35),
);

Widget bottomBarButton3(context) => IconButton(
  enableFeedback: false,
  onPressed: () => Navigator.pushNamed(context, '/3'),
  icon: const Icon(Icons.widgets_outlined, color: Colors.white, size: 35),
);

Widget bottomBarButton4(context) => IconButton(
  enableFeedback: false,
  onPressed: () => Navigator.pushNamed(context, '/4'),
  icon: const Icon(Icons.person_outline, color: Colors.white, size: 35),
);

