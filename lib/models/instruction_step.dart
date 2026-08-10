class InstructionStep {
  final int step;
  final String text;

  /// Optional timer attached to this instruction.
  final int? timerSeconds;

  const InstructionStep({
    required this.step,
    required this.text,
    this.timerSeconds,
  });

  Map<String, dynamic> toJson() {
    return {
      'step': step,
      'text': text,
      'timerSeconds': timerSeconds,
    };
  }

  factory InstructionStep.fromJson(Map<String, dynamic> json) {
    return InstructionStep(
      step: json['step'] ?? 0,
      text: json['text'] ?? '',
      timerSeconds: json['timerSeconds'],
    );
  }
}