package util;

import java.math.BigDecimal;

public class Validador {

    private Validador() {
    }

    public static boolean estaVacio(String valor) {
        return valor == null || valor.trim().isEmpty();
    }

    public static int convertirEntero(String valor, int valorDefecto) {
        try {
            return Integer.parseInt(valor);
        } catch (NumberFormatException ex) {
            return valorDefecto;
        }
    }

    public static BigDecimal convertirDecimal(String valor, BigDecimal valorDefecto) {
        try {
            return new BigDecimal(valor);
        } catch (NumberFormatException | NullPointerException ex) {
            return valorDefecto;
        }
    }

    public static boolean esEnteroNoNegativo(int valor) {
        return valor >= 0;
    }

    public static boolean esEnteroPositivo(int valor) {
        return valor > 0;
    }

    public static boolean esDecimalPositivo(BigDecimal valor) {
        return valor != null && valor.compareTo(BigDecimal.ZERO) > 0;
    }
}
