String defectOrCoop(String input, {bool extended = false}) {
  if (extended) {
    return input == 'C'
        ? 'Der Gegner hat kooperiert'
        : 'Der Gegner hat Defektiert';
  }

  return input == 'C' ? 'Kooperiert' : 'Defektiert ';
}

String mapUnderstanding(int input) {
  switch (input) {
    case 0:
      return 'Garnicht';
    case 1:
      return 'Wenig';
    case 2:
      return 'Mittelmässig';
    case 3:
      return 'Gut';
    case 4:
      return 'Sehr gut';
  }
  return 'Error';
}

String mapStruggles(int value, String text) {
  switch (value) {
    case 0:
      return 'Ja: $text';
    case 1:
      return 'Nein';
  }
  return 'Error';
}

String mapFairness(int fairness) {
  switch (fairness) {
    case 0:
      return 'Sehr unfair';
    case 1:
      return 'Unfair';
    case 2:
      return 'Neutral';
    case 3:
      return 'Fair';
    case 4:
      return 'Sehr fair';
  }
  return 'Error';
}

String mapCooperations(int cooperations) {
  switch (cooperations) {
    case 0:
      return 'Nie';
    case 1:
      return 'Selten';
    case 2:
      return 'Manchmal';
    case 3:
      return 'Oft';
    case 4:
      return 'Immer';
  }
  return 'Error';
}

String mapDidAnalyze(int input, String text) {
  switch (input) {
    case 0:
      return 'Ja: $text';
    case 1:
      return 'Nein';
  }
  return 'Error';
}

String mapHowWasEnemy(int input) {
  switch (input) {
    case 0:
      return 'Sehr kooperativ';
    case 1:
      return 'Kooperativ';
    case 2:
      return 'Neutral';
    case 3:
      return 'Konkurrenzorientiert';
    case 4:
      return 'Sehr konkurrenzorientiert';
  }
  return 'Error';
}

String mapDidCpuManipulate(int didCpuManipulate, String text) {
  switch (didCpuManipulate) {
    case 0:
      return 'Ja: $text';
    case 1:
      return 'Nein';
  }
  return 'Error';
}

String mapPerformance(int input) {
  switch (input) {
    case 0:
      return 'Sehr unzufrieden';
    case 1:
      return 'Unzufrieden';
    case 2:
      return 'Neutral';
    case 3:
      return 'Zufrieden';
    case 4:
      return 'Sehr unzufrieden';
  }
  return 'Error';
}
