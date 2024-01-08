import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);


  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff756EF3),
      surfaceTint: Color(4283714760),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4285162720),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282400364),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285689761),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4286059120),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4290006182),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(0xffffffff),
      onBackground: Color(0xff002055),
      surface: Color(4294768895),
      onSurface: Color(4279966498),
      surfaceVariant: Color(4293189874),
      onSurfaceVariant: Color(4282597711),
      outline: Color(4284439916),
      outlineVariant: Color(4286282121),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281347896),
      inverseOnSurface: Color(4294176762),
      inversePrimary: Color(4291084543),
      primaryFixed: Color(4285162720),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4283517638),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285689761),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4284045191),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4290006182),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4288033419),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292663523),
      surfaceBright: Color(4294768895),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294374141),
      surfaceContainer: Color(4293979383),
      surfaceContainerHigh: Color(4293584625),
      surfaceContainerHighest: Color(4293190124),
    );
  }



  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4291347967),
      surfaceTint: Color(4291084543),
      onPrimary: Color(4279042137),
      primaryContainer: Color(4287070719),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4291413500),
      onSecondary: Color(4279373628),
      secondaryContainer: Color(4287531967),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294947566),
      onTertiary: Color(4281335853),
      tertiaryContainer: Color(4292176325),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279440154),
      onBackground: Color(4293190124),
      surface: Color(4279440154),
      onSurface: Color(4294834687),
      surfaceVariant: Color(4282860883),
      onSurfaceVariant: Color(4291611098),
      outline: Color(4288979378),
      outlineVariant: Color(4286808465),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293190124),
      inverseOnSurface: Color(4280953137),
      inversePrimary: Color(4282135217),
      primaryFixed: Color(4293124095),
      onPrimaryFixed: Color(4278779979),
      primaryFixedDim: Color(4291084543),
      onPrimaryFixedVariant: Color(4280883615),
      secondaryFixed: Color(4293124095),
      onSecondaryFixed: Color(4279044407),
      secondaryFixedDim: Color(4291084792),
      onSecondaryFixedVariant: Color(4281545054),
      tertiaryFixed: Color(4294957042),
      onTertiaryFixed: Color(4280746020),
      tertiaryFixedDim: Color(4294945773),
      onTertiaryFixedVariant: Color(4284874848),
      surfaceDim: Color(4279440154),
      surfaceBright: Color(4281940033),
      surfaceContainerLowest: Color(4279110933),
      surfaceContainerLow: Color(4279966498),
      surfaceContainer: Color(4280229671),
      surfaceContainerHigh: Color(4280953137),
      surfaceContainerHighest: Color(4281676860),
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
