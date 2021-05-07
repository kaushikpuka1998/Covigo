import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CovidInformationScreen extends StatefulWidget {
  @override
  _CovidInformationScreenState createState() => _CovidInformationScreenState();
}

class _CovidInformationScreenState extends State<CovidInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Covid Information",
          style: GoogleFonts.mcLaren(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Column(
            children: [
              Container(
                child: Text(
                  "COVID-19 and pregnancy",
                  style: GoogleFonts.mcLaren(color: Colors.red),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  "1. Their is no increased risk of miscarriage or loss of early pregnancy due to COVID.\n\n2. Their may be increased risk of preterm baby and fetal growth abnormality depending on the\nsecverity of disease\n\n3. COVID 19 is not an indication of Medical Termination Of Pregnancy",
                  style: GoogleFonts.mcLaren(color: Colors.blue),
                ),
              ),
              Container(
                child: Text("Antenatal care",
                    style: GoogleFonts.mcLaren(color: Colors.red)),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                    "1. Women showing mild symptoms of COVID 19 infection are requested to stay at home (self )isolation\n\n2. Women with moderate to severe disease must be admitted in wards or HDU and severe cases\n in the ICU.",
                    style: GoogleFonts.mcLaren(color: Colors.green)),
              ),
              Container(
                child: Text("Breast Feeding",
                    style: GoogleFonts.mcLaren(color: Colors.red)),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                    "1.Women with COVID infection can only breastfeed if they wish\n\n2. Practice necessary hyegine\n\n3. Wear a mask\n\n4. Routine cleaning of the hands.",
                    style: GoogleFonts.mcLaren(color: Colors.blue)),
              ),
              Container(
                child: Text("Use Of Remdesivir",
                    style: GoogleFonts.mcLaren(color: Colors.red)),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                    "Approved under Emergency Use Authorization in the management of COVID-19 during the\n replicative phase of the virus, but it has been observed that it has been misused which lead to crisis in\navailability.\n\nIndications\n1. Patients with confirmed COVID-19 by RT_PCR/RAT/CB NAAT\n2. Moderate disease with SpO+2+ &lt;95% on room air with increasing oxygen demand \n 3. Radiograph showing lung infiltration\n\n\nUse\n\nWith 5-10 days of onset of symptoms (not used if more than 10 days)\n\nDose\n\n200 mg through intravenous route( IV) OD on Day 1 followed by 100 mg IV for a total duration of 5\ndays\n\nContraindications\n\n1. Hepatic dysfunction ALT/AST&gt;5 times the upper limit\n2. eGFR &lt;30ml/min or Renal Replacement Therapy\n3. Pregnant or Breastfeeding\n\nPrecautions\n\nPerform LFT on alternate day of Remdesivir administration\n\nIt has been seen that only 10-20% cases require the drug",
                    style: GoogleFonts.mcLaren(color: Colors.green)),
              ),
              Container(
                child: Text("Use Of Toculizumab",
                    style: GoogleFonts.mcLaren(color: Colors.red)),
              ),
              Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "It is indicated in severe cases of COVID infection with cytokine storm.\n\n It must be used cautiously as it may cause weakening of the immune system so that secondary\ninfection may be difficult to treat.\n\nIndications\n\n1. Recent ICU admissions within prior 24 hours\n2. Who require IMV,NIV or HFNC oxygen\n3. Recently hospitalised patients with increasing oxygen demand and significantly increased\nmarkers of inflammation,\n\nDosage\n\nSingle IV dose of 8mg/kg of actual body weight ,up to 800mg in combination with dexamethasone in\ncertain hospitalised patients\n\nContraindication\n\nImmunosupression",
                    style: GoogleFonts.mcLaren(color: Colors.blue),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
