/* ***************************************************************
 * @author      : Gerardo Yandún
 * @model        : PagoPluxModel
 * @description  : Componente modal que invoca a PagoPlux
 * @version  : v1.0.0
 * @copyright (c)  PagoPlux 2021
 *****************************************************************/
class PagoPluxModel {
  String payboxRename;
  String payboxSendname;
  String payboxRemail;
  bool payboxProduction;
  String payboxSendmail;
  String payboxEnvironment;
  String payboxDescription;
  double payboxBase0;
  double payboxBase12;
  String payboxCreditType;
  int payboxNumInstallments;
  String payboxInteres;
  int payboxGraceMonths;
  bool payboxIntoDataPayment;
  bool payboxRecurrent;
  String payboxIdPlan;
  bool payboxPermitirCalendarizar;
  bool payboxPagoInmediato;
  bool payboxCobroPrueba;

  String payboxClientName;
  String payboxClientPhone;
  String payboxDirection;
  String payboxSendEmail;
  String payboxPaymentValue;
  String payboxClientIdentification;
  String PayboxDirection;

  PagoPluxModel({
    this.payboxRemail = '',
    this.payboxEnvironment = '',
    this.payboxProduction = false,
    this.payboxBase0 = 0,
    this.payboxBase12 = 0,
    this.payboxSendname = '',
    this.payboxSendmail = '',
    this.payboxRename = '',
    this.payboxDescription = '',
    this.payboxInteres = '',
    this.payboxCreditType = '',
    this.payboxNumInstallments = 0,
    this.payboxGraceMonths = 0,
    this.payboxPagoInmediato = false,
    this.payboxPermitirCalendarizar = false,
    this.payboxIdPlan = '',
    this.payboxRecurrent = false,
    this.payboxIntoDataPayment = false,
    this.payboxCobroPrueba = true,
    this.payboxClientName = '',
    this.payboxClientPhone = '',
    this.payboxDirection = '',
    this.payboxSendEmail = '',
    this.payboxPaymentValue = '',
    this.payboxClientIdentification = '',
    this.PayboxDirection = '',

  });
}
