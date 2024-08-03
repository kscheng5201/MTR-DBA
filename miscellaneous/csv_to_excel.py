import pandas as pd
import tkinter as tk
from tkinter import filedialog
import os
# 套件 pandas openpyxl
# 沒有的話要先pip

def convert_to_excel(input_file):
    # 讀取檔案
    if input_file.endswith('.csv'):
        df = pd.read_csv(input_file)
    elif input_file.endswith('.txt'):
        df = pd.read_csv(input_file, sep=',') # 預設分隔符號為逗號
    else:
        print("Unsupported file format.")
        return

    # 將資料寫入Excel
    output_file = input_file.replace('.csv', '.xlsx').replace('.txt', '.xlsx')
    df.to_excel(output_file, index=False)
    print("Conversion successful. Excel file saved as:", output_file)

def select_folder():
    root = tk.Tk()
    root.withdraw()
    folder_path = filedialog.askdirectory()
    return folder_path

def main():
    folder_path = select_folder()
    if folder_path:
        # 列出資料夾中的所有檔案
        files = os.listdir(folder_path)
        for file in files:
            # 如果檔案是csv或txt檔案，則進行轉換
            if file.endswith('.txt'):
                convert_to_excel(os.path.join(folder_path, file))
        print("All files in the folder are converted to Excel.")
    else:
        print("No folder selected.")

if __name__ == "__main__":
    main()
