class signUpWithEmailAndPasswordFailure {
  final String message1;

  const signUpWithEmailAndPasswordFailure(
      [this.message1 = "A Ocurrido un error"]);

  factory signUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const signUpWithEmailAndPasswordFailure('ingrese contraseña');
      case 'invalid-email':
        return const signUpWithEmailAndPasswordFailure('el email no valido');
      case 'email-already-in-use':
        return const signUpWithEmailAndPasswordFailure('correo existente');
      case 'user-disabled':
        return const signUpWithEmailAndPasswordFailure('usuario deshabilitado');

      default:
        return const signUpWithEmailAndPasswordFailure();
    }
  }
}
