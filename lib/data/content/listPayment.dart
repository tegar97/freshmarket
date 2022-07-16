class ListPayment {
  String? serviceName;
  String? serviceLogo;
  bool? isAvaible;
  String? serviceApi;

  ListPayment(
      {required this.serviceName,this.serviceLogo,this.isAvaible,required this.serviceApi});
}

List<ListPayment> servicePayment = [
  ListPayment(
      serviceName: 'Mandiri Bill',
      serviceLogo: 'assets/images/mandiri.png',
      isAvaible: true,
      serviceApi: 'mandiri'
      ),
  ListPayment(
      serviceName: 'BCA Virtual Account',
      serviceLogo: 'assets/images/bca.png',
      isAvaible: true,
      serviceApi: 'bca'
      ),
  ListPayment(
      serviceName: 'Indomaret',
      serviceLogo: 'assets/images/indomaret.png',
      isAvaible: true,
      serviceApi: 'indomaret'
      ),
 
];
