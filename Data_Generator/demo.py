import pandas as pd

dz = pd.read_csv(r"C:\ProjectVelox\delivery_zones.csv")

print(dz.shape)
print(dz["zone_id"].min())
print(dz["zone_id"].max())
print(dz["zone_id"].nunique())
print(sorted(dz["zone_id"].tolist()))