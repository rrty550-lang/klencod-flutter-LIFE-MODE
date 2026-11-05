
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LifeModeApp());
}

class LifeModeApp extends StatefulWidget {
  const LifeModeApp({super.key});

  @override
  State<LifeModeApp> createState() => _LifeModeAppState();
}

class _LifeModeAppState extends State<LifeModeApp> {
  bool isArabic = true;

  @override
  void initState() {
    super.initState();
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      isArabic = prefs.getBool('isArabic') ?? true;
    });
  }

  Future<void> changeLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => isArabic = !isArabic);
    await prefs.setBool('isArabic', isArabic);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LIFE MODE',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B1020),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF5795FF),
          secondary: Color(0xFF9B7BFF),
          surface: Color(0xFF151D30),
        ),
        useMaterial3: true,
      ),
      home: Directionality(
        textDirection:
            isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: HomePage(
          isArabic: isArabic,
          onLanguageChange: changeLanguage,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final bool isArabic;
  final VoidCallback onLanguageChange;

  const HomePage({
    super.key,
    required this.isArabic,
    required this.onLanguageChange,
  });

  String get tWelcome =>
      isArabic ? 'أهلاً بك في يوم جديد!' : 'Welcome to a new day!';

  String get tSubtitle =>
      isArabic ? 'اجعل يومك أفضل، خطوة بخطوة.' : 'Make your day better, step by step.';

  @override
  Widget build(BuildContext context) {
    final modes = [
      ModeData(
        'study',
        isArabic ? 'وضع الدراسة' : 'Study Mode',
        isArabic ? 'تعلم وركز وحقق أهدافك' : 'Learn, focus and achieve',
        Icons.menu_book_rounded,
        const Color(0xFF3978F6),
      ),
      ModeData(
        'work',
        isArabic ? 'وضع العمل' : 'Work Mode',
        isArabic ? 'نظم أعمالك ومهامك' : 'Organize your work',
        Icons.work_rounded,
        const Color(0xFF9B70F5),
      ),
      ModeData(
        'travel',
        isArabic ? 'وضع السفر' : 'Travel Mode',
        isArabic ? 'جهز رحلتك بسهولة' : 'Prepare your journey',
        Icons.flight_takeoff_rounded,
        const Color(0xFF16BFA7),
      ),
      ModeData(
        'money',
        isArabic ? 'الوضع المالي' : 'Money Mode',
        isArabic ? 'تابع مصروفاتك وميزانيتك' : 'Track your money',
        Icons.account_balance_wallet_rounded,
        const Color(0xFFE5A83B),
      ),
      ModeData(
        'daily',
        isArabic ? 'الوضع اليومي' : 'Daily Mode',
        isArabic ? 'طور عاداتك اليومية' : 'Build better habits',
        Icons.wb_sunny_rounded,
        const Color(0xFFEF729A),
      ),
      ModeData(
        'reset',
        isArabic ? 'وضع إعادة التنظيم' : 'Reset Mode',
        isArabic ? 'راجع يومك واستعد للغد' : 'Review and reset',
        Icons.refresh_rounded,
        const Color(0xFF38B9E8),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF3985FF),
                            Color(0xFF9565F5),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.bolt_rounded,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                    const SizedBox(width: 11),
                    const Expanded(
                      child: Text(
                        'LIFE MODE',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: onLanguageChange,
                      icon: const Icon(Icons.language_rounded),
                      tooltip: isArabic ? 'English' : 'العربية',
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tWelcome,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tSubtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF9BA8C0),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1E3970),
                        Color(0xFF30245D),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isArabic
                            ? 'إنجازك اليومي'
                            : 'YOUR DAILY PROGRESS',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '0%',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.trending_up_rounded,
                            size: 30,
                            color: Color(0xFF7CC8FF),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const LinearProgressIndicator(
                          value: 0,
                          minHeight: 8,
                          backgroundColor: Color(0xFF52628A),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(
                            Color(0xFF65D6B0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        isArabic
                            ? 'ابدأ أول إنجاز لك اليوم!'
                            : 'Start your first achievement today!',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 27, 20, 15),
              sliver: SliverToBoxAdapter(
                child: Text(
                  isArabic ? 'اختر وضعك الآن' : 'Choose your mode',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final mode = modes[index];

                    return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Directionality(
                              textDirection: isArabic
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              child: ModePage(
                                mode: mode,
                                isArabic: isArabic,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color(0xFF151D30),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.06),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(11),
                              decoration: BoxDecoration(
                                color: mode.color.withOpacity(0.15),
                                borderRadius:
                                    BorderRadius.circular(13),
                              ),
                              child: Icon(
                                mode.icon,
                                color: mode.color,
                                size: 27,
                              ),
                            ),
                            const SizedBox(height: 13),
                            Text(
                              mode.title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              mode.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF9BA8C0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: modes.length,
                ),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 13,
                  crossAxisSpacing: 13,
                  childAspectRatio: 1.12,
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    isArabic
                        ? 'حياتك، أهدافك، إنجازاتك.'
                        : 'Your life. Your goals. Your progress.',
                    style: const TextStyle(
                      color: Color(0xFF71809B),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModeData {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  ModeData(
    this.id,
    this.title,
    this.description,
    this.icon,
    this.color,
  );
}

class ModePage extends StatelessWidget {
  final ModeData mode;
  final bool isArabic;

  const ModePage({
    super.key,
    required this.mode,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mode.title),
        backgroundColor: const Color(0xFF0B1020),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: mode.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  mode.icon,
                  size: 65,
                  color: mode.color,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                mode.title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                isArabic
                    ? 'أهلاً بك! سنضيف أدوات هذا الوضع قريباً.'
                    : 'Welcome! Tools for this mode are coming soon.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF9BA8C0),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
