String defectOrCoop(String input, {bool extended = false}) {
  if (extended) {
    return input == 'C'
        ? 'Der Dealer hat ehrlich gehandelt'
        : 'Der Dealer hat betrogen';
  }

  return input == 'C' ? 'ehrlich gehandelt' : 'betrogen ';
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
      return 'Nein';
    case 1:
      return 'Ja: $text';
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
      return 'Nein';
    case 1:
      return 'Ja: $text';
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
      return 'Nein';
    case 1:
      return 'Ja: $text';
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

String mapUsePlayerTermn(bool input) => input ? 'Spieler' : 'Computer';
