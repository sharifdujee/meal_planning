import 'dart:ui';

class AppColor {
  AppColor._();

  // ── Legacy / auth colors (kept for compatibility) ──────────────────────────
  static const Color primary           = Color(0xFF4CAF7D);   // bright green arrow / back icon
  static const Color white             = Color(0xFFFFFFFF);
  static const Color containerBackground = Color(0xFF0F1F19);
  static const Color textBody          = Color(0xFF6D7179);
  static const Color pendingColor      = Color(0xFFFAAD14);
  static const Color quoteColor        = Color(0xFF4A4E5A);
  static const Color authColor         = Color(0xFF191919);
  static const Color authDescriptionColor = Color(0xFF5B616E);
  static const Color black             = Color(0xFF000000);
  static const Color error             = Color(0xFFFF0000);
  static const Color headerColor       = Color(0xFF2D2D2D);
  static const Color profileTextColor  = Color(0xFF757575);
  static const Color socialLogoColor   = Color(0xFF126A19);
  static const Color containerBorder   = Color(0xFF1A2E25);

  // ── Core dark-theme palette (matched to screenshot) ───────────────────────
  /// Page background — near-black with green undertone
  static const Color background        = Color(0xFF0A1410);

  /// Card surface (option tiles)
  static const Color surface           = Color(0xFF0F2019);
  static const Color card              = Color(0xFF112318);

  /// Card borders
  static const Color cardBorder        = Color(0xFF1C3527);
  static const Color cardBorderSelected = Color(0xFF4CAF7D);

  /// Bright mint-green — progress fill, button, icons
  static const Color accent            = Color(0xFF4CAF7D);
  static const Color accentDim         = Color(0xFF1E5C3A);

  /// Primary text — pure white
  static const Color textPrimary       = Color(0xFFFFFFFF);

  /// Secondary text — muted green-grey ("Paso 1 de 7")
  static const Color textSecondary     = Color(0xFF6B8A78);

  /// Inactive progress dots
  static const Color textMuted         = Color(0xFF1E3529);

  /// Input fields
  static const Color inputBg           = Color(0xFF0D1A14);
  static const Color inputBorder       = Color(0xFF1A2E25);

  /// Radial gradient — top-left bright zone fading to background
  static const Color gradientStart     = Color(0xFF1A4D35);   // bright teal-green glow
  static const Color gradientMid       = Color(0xFF0C1C16);   // mid dark-green
  static const Color welcomeQuoteColor       = Color(0xFF8E95A2);


  static const Color cardBackground = Color(0xFF1F2228);

  static const Color danger = Color(0xFFE05252);
  static const Color warning = Color(0xFFE08C52);


  // mid dark-green
}