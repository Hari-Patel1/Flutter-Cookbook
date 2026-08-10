Greeting(int hour) {
  if ((hour >= 0) && (hour < 12)) {
    return "Good morning!";
  }
  if ((hour >= 12) && (hour < 18)) {
    return "Good afternoon!";
  }
  if ((hour >= 18) && (hour < 24)) {
    return "Good evening!";
  }

  return "Hello, $hour!";
}