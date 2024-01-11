import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);


  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff756EF3),
      surfaceTint: Color(0xff544cc8),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6a64e0),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff403e6c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff726fa1),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff781270),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffb44ca6),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xffffffff),
      onBackground: Color(0xff002055),
      surface: Color(0xfffcf8ff),
      onSurface: Color(0xff1b1b22),
      surfaceVariant: Color(0xffe4e0f2),
      onSurfaceVariant: Color(0xff43414f),
      outline: Color(0xff5f5d6c),
      outlineVariant: Color(0xff7b7989),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff302f38),
      inverseOnSurface: Color(0xfff3effa),
      inversePrimary: Color(0xffc4c0ff),
      primaryFixed: Color(0xff6a64e0),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff514ac6),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff726fa1),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff595787),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffb44ca6),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff96328b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdcd8e3),
      surfaceBright: Color(0xfffcf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f2fd),
      surfaceContainer: Color(0xfff0ecf7),
      surfaceContainerHigh: Color(0xffeae6f1),
      surfaceContainerHighest: Color(0xffe4e1ec),
    );
  }



  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc8c5ff),
      surfaceTint: Color(0xffc4c0ff),
      onPrimary: Color(0xff0d0059),
      primaryContainer: Color(0xff8781ff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffc9c5fc),
      onSecondary: Color(0xff120f3c),
      secondaryContainer: Color(0xff8e8bbf),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffb2ee),
      onTertiary: Color(0xff30002d),
      tertiaryContainer: Color(0xffd569c5),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff13131a),
      onBackground: Color(0xffe4e1ec),
      surface: Color(0xff13131a),
      onSurface: Color(0xfffdf9ff),
      surfaceVariant: Color(0xff474553),
      onSurfaceVariant: Color(0xffccc9da),
      outline: Color(0xffa4a1b2),
      outlineVariant: Color(0xff838191),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e1ec),
      inverseOnSurface: Color(0xff2a2931),
      inversePrimary: Color(0xff3c32b1),
      primaryFixed: Color(0xffe3dfff),
      onPrimaryFixed: Color(0xff09004b),
      primaryFixedDim: Color(0xffc4c0ff),
      onPrimaryFixedVariant: Color(0xff29199f),
      secondaryFixed: Color(0xffe3dfff),
      onSecondaryFixed: Color(0xff0d0937),
      secondaryFixedDim: Color(0xffc4c1f8),
      onSecondaryFixedVariant: Color(0xff33315e),
      tertiaryFixed: Color(0xffffd7f2),
      onTertiaryFixed: Color(0xff270024),
      tertiaryFixedDim: Color(0xffffabed),
      onTertiaryFixedVariant: Color(0xff660060),
      surfaceDim: Color(0xff13131a),
      surfaceBright: Color(0xff393841),
      surfaceContainerLowest: Color(0xff0e0d15),
      surfaceContainerLow: Color(0xff1b1b22),
      surfaceContainer: Color(0xff1f1f27),
      surfaceContainerHigh: Color(0xff2a2931),
      surfaceContainerHighest: Color(0xff35343c),
    );
  }





  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
