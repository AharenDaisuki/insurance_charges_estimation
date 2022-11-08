pacman::p_load('dplyr')

cleanData<-function(filePathName){
  df = read.csv(file = filePathName);
  # clean missing data
  print('[filter missing value...]');
  print('[raw row size]:')
  print(nrow(df));
  phaseI = df %>% filter(!is.na(bmi) & !is.na(charges));
  print('[phase I]:')
  print(nrow(phaseI));
  # clean bmi outliers
  print('[filter bmi outliers...]');
  bmiCol = dplyr::pull(phaseI, 'bmi');
  bmiIqr = IQR(bmiCol);
  phaseII = phaseI %>% filter(quantile(bmiCol, 0.25) - 1.5*bmiIqr < bmi & bmi < quantile(bmiCol, 0.75) + 1.5*bmiIqr)
  print('[phase II]')
  print(nrow(phaseII))
  # print(bmiIqr);
  # clean charges outliers
  print('[filter charges outliers...]');
  chgCol = dplyr::pull(phaseI, 'charges');
  chgIqr = IQR(chgCol);
  phaseIII = phaseII %>% filter(quantile(chgCol, 0.25) - 1.5*chgIqr < charges & charges < quantile(chgCol, 0.75) + 1.5*chgIqr)
  print('[phase III]')
  print(nrow(phaseIII))
  # print(chgIqr);
  phaseIII
}
