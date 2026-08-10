Greeting(int hour) {
  if (hour >= 0) {
    return "Good morning!";
  }
  if (hour >= 12) {
    return "Good afternoon!";
  }
  if (hour >= 18) {
    return "Good evening!";
  }

  return "Hello, $hour!";
}