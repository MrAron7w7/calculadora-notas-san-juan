class Calculate {
  Calculate();

  double calculateNote(
    double pc1,
    double pc2,
    double pc3,
    double pc4,
    double exaFinal,
    double parcial,
  ) {
    double porcentaje15 = 0.15;
    double porcentaje20 = 0.2;
    double promedio = (pc1 * porcentaje15) +
        (pc2 * porcentaje15) +
        (pc3 * porcentaje15) +
        (pc4 * porcentaje15) +
        (parcial * porcentaje20) +
        (exaFinal * porcentaje20);
    return promedio;
  }
}
