ReturnType run<ReturnType>(ReturnType Function() operation) {
  return operation();
}

extension ScopeFunctionsForObject<T extends Object> on T {
  ReturnType let<ReturnType>(ReturnType Function(T it) scopeFunction) {
    return scopeFunction(this);
  }

  T also(void Function(T it) scopeFunction) {
    scopeFunction(this);
    return this;
  }
}
