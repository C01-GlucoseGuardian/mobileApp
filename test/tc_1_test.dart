import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_guardian/screens/paziente_send_feedback.dart';

void main() {
  group(
    'TC_1',
    () {
      final PazienteSendFeedback screen = PazienteSendFeedback();

      test("TC_1.1", () {
        String statuSalute =
            "blablablablablablablablablablablblablablablablablablablablablablblablablablablablablablablablablblablablablablablablablablablablblablablablablablablablablablablblablablablablablablablablablablblablablablablablablablablablablblablablablablablablablablablablblablablablablablablablablablablblablablablablablablablablablabla";
        String oreSonno = "Ieri notte ho dormito poche ore";
        String dolori = "Nessun dolore avvertito";
        String svenimenti = "Non sono mai svenuto negli ultimi giorni";

        String? res =
            screen.validate(statuSalute, oreSonno, dolori, svenimenti);
        expect(
          res,
          equals("Lunghezza stato salute non valida"),
        );
      });

      test("TC_1.2", () {
        String statuSalute = "Mi sono sentito molto bene ieri";
        String oreSonno = "";
        String dolori = "Nessun dolore avvertito";
        String svenimenti = "Non sono mai svenuto negli ultimi giorni";

        String? res =
            screen.validate(statuSalute, oreSonno, dolori, svenimenti);
        expect(
          res,
          equals("Le ore di sonno non possono essere vuote"),
        );
      });

      test("TC_1.3", () {
        String statuSalute = "Mi sono sentito molto bene ieri";
        String oreSonno = "Ieri notte ho dormito poche ore";
        String dolori =
            "Okokokokok122932’012012012010sjidjsidajdajdiajdu4ur843r023ei12iopsiqddkamdkadmjdnurnfiwjdowjdpoqdjief843ht8fheodhihdisahdihiqhwidh38rh328hd9dhihdioancoincfiehdiqhwd8h38ehqhioqhdinakmoiejeiej3eijwidwiwjdncufufOkokokokok122932’012012012010sjidjsidajdajdiajdu4ur843r023ei12iopsiqddkamdkadmjdnurnfiwjdowjdpoqdjief843ht8fheodhihdisahdihiqhwidh38rh328hd9dhihdioancoincfiehdiqhwd8h38ehqhioqhdinakmoiejeiej3eijwidwiwjdncufuf";
        String svenimenti = "Non sono mai svenuto negli ultimi giorni";

        String? res =
            screen.validate(statuSalute, oreSonno, dolori, svenimenti);
        expect(
          res,
          equals("Lunghezza dolori non valida"),
        );
      });

      test("TC_1.4", () {
        String statuSalute = "Mi sono sentito molto bene ieri";
        String oreSonno = "Ieri notte ho dormito poche ore";
        String dolori = "Nessun dolore avvertito";
        String svenimenti = "";

        String? res =
            screen.validate(statuSalute, oreSonno, dolori, svenimenti);
        expect(
          res,
          equals("Gli svenimenti non possono essere vuoti"),
        );
      });

      test("TC_1.5", () {
        String statuSalute = "Mi sono sentito molto bene ieri";
        String oreSonno = "Ieri notte ho dormito poche ore";
        String dolori = "Nessun dolore avvertito";
        String svenimenti = "Nessun che io ricordi";

        String? res =
            screen.validate(statuSalute, oreSonno, dolori, svenimenti);
        expect(
          res,
          isNull,
        );
      });
    },
  );
}
