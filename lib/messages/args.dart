enum ArgErrorMessages {
  missingInput('Argument -i and a value was not provided.');

  const ArgErrorMessages(this.message);

  final String message;
}
