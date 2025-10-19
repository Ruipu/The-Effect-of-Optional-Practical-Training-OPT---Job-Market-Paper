# 🎓 The Effect of Optional Practical Training (OPT) on U.S. College Graduates

Hi there 👋 — this repository contains part of my **Job Market Paper**, where I explore how changes in the U.S. **OPT (Optional Practical Training)** program have shaped the labor market outcomes of both **foreign** and **domestic** college graduates.

Using large-scale data from the **Current Population Survey (CPS, 2000–2024)**, I analyze how the 2008 and 2016 OPT extensions affected:
- 🎯 **Occupation choice** — who enters STEM jobs, and when  
- 💰 **Wages** — how the earnings gap evolved between STEM and non-STEM workers  
- 🌍 **Differences by citizenship** — contrasting U.S. and international graduates  

---

## 📊 Repository Structure

| File | Description |
|------|--------------|
| [`Trend of Occupation Choice and Wage.md`](./Trend%20of%20Occupation%20Choice%20and%20Wage.md) | Shows long-term trends in occupation composition and wage differentials between STEM and non-STEM fields. Includes visualizations for both domestic and foreign graduates. |
| [`Trends of Majors.md`](./Trends of Majors.md) | Examines changes in the share of STEM degrees over time for bachelor’s and master’s graduates, by citizenship. Highlights how foreign STEM shares rose sharply after OPT extensions. |
| [`EDA_ASEC.ipynb`](./EDA_ASEC.ipynb) | Exploratory Data Analysis (EDA) for the CPS ASEC dataset, covering demographic structure, employment status, weekly working hours, and unemployment patterns. Includes data cleaning, visualizations, and descriptive insights. |

---

## 🔍 Key Insights

- 🧑‍🎓 **Foreign students** dramatically increased their share of STEM degrees after the 2016 OPT extension — especially at the master’s level.  
- 💼 **Domestic students** also moved slightly toward STEM fields, but much more gradually.  
- 📈 **Foreign STEM participation** and wages surged post-2016, while domestic trends remained stable.  
- 💬 Overall, OPT seems to have **strengthened incentives for foreign STEM specialization** without clear evidence of crowding out U.S. graduates.  

---

## 📊 EDA_ASEC: Exploratory Findings from CPS Microdata

This notebook ([`EDA_ASEC.ipynb`](./EDA_ASEC.ipynb)) provides a broad overview of the CPS ASEC microdata used in this study.

### 🧱 Demographic Highlights
- The sample shows a balanced **gender composition** (≈51% female, 49% male).  
- The **age distribution** peaks in the late 20s to early 30s, reflecting the concentration of early-career workers.  
- The population is **predominantly White and Black**, with smaller representation from Asian and other racial groups.  
- **Regional representation** aligns with national population weights, led by the South Atlantic and Pacific divisions.

### 💼 Labor Market Overview
- **Full-time workers** (35+ hours/week) dominate the sample, while part-time and unemployed individuals make up smaller shares.  
- The **distribution of weekly working hours** centers tightly around 40, confirming the standard full-time benchmark.  
- By industry, **STEM-related and professional sectors** exhibit slightly higher average weekly hours.  
- Unemployment reasons are led by **job loss** and **temporary job endings**, consistent with cyclical labor turnover.

### 💡 Key Takeaways
- The U.S. labor market remains **heavily full-time oriented**, with most workers clustered around standard hours.  
- **Involuntary unemployment** dominates over voluntary job switching, hinting at macro-level shocks and structural mismatches.  
- Demographically, the dataset captures a **diverse but balanced cross-section** of the U.S. labor force — suitable for examining education–occupation linkages and policy effects like OPT.

---

## 🛠️ Data & Tools

- **Data:** Current Population Survey (CPS ASEC, 2000–2024)  
- **Software:** Stata (data processing), Python (EDA & visualization)  
- **Languages:** Stata · Python · Markdown  
- **Visualization Libraries:** seaborn · matplotlib · plotly  

---

## 🤓 Why This Matters

The OPT program is a cornerstone of U.S. immigration and education policy — it shapes how international students transition into the U.S. labor market.  
By combining **policy analysis**, **labor economics**, and **data visualization**, this project offers a structured empirical view of how migration policy affects real-world labor dynamics.

---

## 🧠 Author

**Ruipu (Simon) — Ph.D. Candidate in Economics, Tulane University**  
📬 Research areas: Labor & Education Economics, Applied Microeconometrics  
💻 Coding in Stata · R · Python · SQL  
📈 Passionate about turning data into insight and insight into impact  

---

⭐ *If you’re curious about policy-driven labor market dynamics — or you just love a good story told with data — you’re in the right repo.*
