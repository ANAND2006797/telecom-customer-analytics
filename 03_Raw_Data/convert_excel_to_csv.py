from pathlib import Path
import pandas as pd

base_dir = Path(__file__).resolve().parent

input_file = base_dir / "telecom_customer_churn.xlsx"
output_file = base_dir / "telecom_customer_churn.csv"

# Read Excel source file
df = pd.read_excel(input_file)

# Convert ZIP Code to integer-like text.
# Blank ZIP codes remain blank.
df["Zip Code"] = df["Zip Code"].apply(
    lambda x: "" if pd.isna(x) else str(int(x))
)

# Export CSV
df.to_csv(
    output_file,
    index=False,
    encoding="utf-8"
)

print("Rows:", len(df))
print("Columns:", len(df.columns))
print("CSV created successfully:")
print(output_file)