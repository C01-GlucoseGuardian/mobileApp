/// checks if glucose value is normal or not
///
/// TODO: change UOM to mg/dL
bool isGlucoseValueNormal(double value) => value > 3.9 && value <= 5.5;
const String kGlucoseUOM = "mmol/L";
