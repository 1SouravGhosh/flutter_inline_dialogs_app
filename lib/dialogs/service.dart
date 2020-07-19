import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inline_dialogs_app/dialogs/model.dart';

class DialogService {
  Function(DialogRequest) _showDialogListener;
  Function(DialogRequest) _dismissDialogListener;
  Completer<DialogResponse> _dialogCompleter;

  void registerDialogListener(
    Function(DialogRequest) showDialogListener,
    Function(DialogRequest) dismissDialogListener,
  ) {
    _showDialogListener = showDialogListener;
    _dismissDialogListener = dismissDialogListener;
  }

  Future<DialogResponse> showDialog(
      {@required Widget title,
      @required Widget content,
      DialogType dialogType,
      String optionLeft,
      String optionRight,
      String buttonText}) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
        title: title,
        description: content,
        buttonText: buttonText,
        dialogType: dialogType,
        optionLeft: optionLeft,
        optionRight: optionRight));
    return _dialogCompleter.future;
  }

  dismissDialog() {
    _dismissDialogListener(DialogRequest());
  }

  void dialogComplete(DialogResponse response) {
    _dialogCompleter.complete(response);
  }
}
