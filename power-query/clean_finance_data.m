// Power Query M starter for an Excel table named FinanceData.
 // Adjust the workbook path, table name, and source field names to match your file.
let
    Source = Excel.Workbook(
        File.Contents("C:\\Data\\finance_transactions.xlsx"),
        null,
        true
    ),
    FinanceData = Source{[Item = "FinanceData", Kind = "Table"]}[Data],
    TrimmedText = Table.TransformColumns(
        FinanceData,
        {
            {"Department", each if _ is text then Text.Trim(_) else _, type text},
            {"ExpenseType", each if _ is text then Text.Trim(_) else _, type text},
            {"Project", each if _ is text then Text.Trim(_) else _, type text},
            {"Approved By", each if _ is text then Text.Trim(_) else _, type text}
        }
    ),
    TypedColumns = Table.TransformColumnTypes(
        TrimmedText,
        {
            {"Date", type date},
            {"Amount", Currency.Type},
            {"Department", type text},
            {"ExpenseType", type text},
            {"Project", type text},
            {"Approved By", type text}
        },
        "en-US"
    ),
    CleanRows = Table.SelectRows(
        TypedColumns,
        each [Date] <> null and [Amount] <> null
    )
in
    CleanRows
