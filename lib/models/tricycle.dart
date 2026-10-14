class Tricycle {
  Tricycle({
    required this.plateNumber,
    required this.driverName,
    required this.route,
    required this.status,
  });

  String plateNumber;
  String driverName;
  String route;
  String status;

  static List<Tricycle> sampleRecords() {
    return [
      Tricycle(
        plateNumber: 'TRI-1024',
        driverName: 'Juan Dela Cruz',
        route: 'Poblacion - Market',
        status: 'Active',
      ),
      Tricycle(
        plateNumber: 'TRI-2048',
        driverName: 'Maria Santos',
        route: 'Market - Seaport',
        status: 'On Break',
      ),
      Tricycle(
        plateNumber: 'TRI-3072',
        driverName: 'Pedro Reyes',
        route: 'Poblacion - School',
        status: 'Active',
      ),
    ];
  }
}
