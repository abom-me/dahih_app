
class FirebaseAuthError{
 static String create(String error,String lang){
    Map<String,Map<String,String>>errorMessages = {
      'email-already-in-use': {
        'ar': 'عفوا، هذا البريد الإلكتروني مستخدم بالفعل',
        'en': 'Sorry, this email is already in use'
      },
      'invalid-email': {
        'ar': 'عذرًا، البريد الإلكتروني غير صحيح',
        'en': 'Sorry, the email is invalid'
      },
      'missing-email': {
        'ar': 'عذرًا، البريد الإلكتروني غير صحيح',
        'en': 'Sorry, the email is invalid'
      },
      'weak-password': {
        'ar': 'عذرًا، كلمة المرور ضعيفة',
        'en': 'Sorry, the password is weak'
      },      'internal-error': {
        'ar': 'عفوا هناك مشكلة في الخادم',
        'en': 'Sorry, internal-error'
      }
    };

    return  errorMessages[error]![lang]!;
  }

  static String login(String error,String lang){
    Map<String,Map<String,String>>errorMessages = {
      'user-not-found': {
        'ar': 'عفوا، لا يوجد مستخدم بهذا البريد الإلكتروني',
        'en': 'Sorry, there is no user with this email'
      },
      'wrong-password': {
        'ar': 'عفوا، كلمة المرور غير صحيحة',
        'en': 'Sorry, the password is incorrect'
      },
      'invalid-email': {
        'ar': 'عذرًا، البريد الإلكتروني غير صحيح',
        'en': 'Sorry, the email is invalid'
      },
      'user-disabled': {
        'ar': 'عذرًا، تم تعطيل هذا المستخدم',
        'en': 'Sorry, this user is disabled'
      },
      'internal-error': {
        'ar': 'عفوا هناك مشكلة في الخادم',
        'en': 'Sorry, internal-error'
      } ,
      'INVALID_LOGIN_CREDENTIALS': {
        'ar': 'عفوا، كلمة المرور غير صحيحة',
        'en': 'Sorry, the password is incorrect'
      }
    };

    return  errorMessages[error]![lang]!;
  }

  resetPassword(String error,String lang){
    Map<String,Map<String,String>>errorMessages = {
      'user-not-found': {
        'ar': 'عفوا، لا يوجد مستخدم بهذا البريد الإلكتروني',
        'en': 'Sorry, there is no user with this email'
      },
      'invalid-email': {
        'ar': 'عذرًا، البريد الإلكتروني غير صحيح',
        'en': 'Sorry, the email is invalid'
      },
      'internal-error': {
        'ar': 'عفوا هناك مشكلة في الخادم',
        'en': 'Sorry, internal-error'
      }
    };

    return  errorMessages[error]![lang]!;
  }

}

