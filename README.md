# mandat-etl-pipeline

This project implements a simple ETL pipeline for processing UZBMB mandate data.  
Raw CSV files are cleaned using **Python (Pandas)** and loaded into **SQL Server** where additional filtering and transformations are applied.

## Tools
- Python
- Pandas
- SQL Server

## Project Structure

mandat-etl-pipeline  
├── data  
│   ├── raw        # raw CSV files (ignored)  
│   └── cleaned    # cleaned dataset (ignored)  
├── scripts        # ETL scripts  
├── sql            # SQL transformations  
└── README.md  

## Data Note
Large datasets are excluded from this repository using `.gitignore` due to GitHub file size limits.  
To reproduce the pipeline, place the raw CSV files in `data/raw/` and run the ETL script.

## Author
Mirfayz Shirinov
