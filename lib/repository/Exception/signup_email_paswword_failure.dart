// ignore: camel_case_types
class signUpWithEmailAndPasswordFailure {
  final String message1;

  const signUpWithEmailAndPasswordFailure(
      [this.message1 = "Ingrese correctamente todos los datos"]);

  factory signUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const signUpWithEmailAndPasswordFailure(
            'Ingrese contraseña mayor a 6 digitos');
      case 'invalid-email':
        return const signUpWithEmailAndPasswordFailure(
            'El correo es incorrecto!!!');
      case 'email-already-in-use':
        return const signUpWithEmailAndPasswordFailure(
            'El correo ya fue registrado');

      case 'user-disabled':
        return const signUpWithEmailAndPasswordFailure('Usuario Deshabilitado');
      case 'user-not-found':
        return const signUpWithEmailAndPasswordFailure('Usuario NO registrado');
      case 'wrong-password':
        return const signUpWithEmailAndPasswordFailure('Contraseña Incorrecta');
      case 'invalid-credential':
        return const signUpWithEmailAndPasswordFailure(
            'Error al entrar por Google');
      case 'too-many-requests':
        return const signUpWithEmailAndPasswordFailure(
            'Demasiados intentos fallidos intente más tarde o recuperé la contraseña');

      default:
        return signUpWithEmailAndPasswordFailure(code);
    }
  }
}
