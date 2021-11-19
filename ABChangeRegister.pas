unit ABChangeRegister;

(*

Ch001 - 11/05/18 - Age of Debt Report modified to allow it to run at a specific point in time. Also updated array to 9999 to cope with Kingswood having over 5000 customers.
                   Age of Debt Report filter screen updated to change filter to offer with balances, greater than, less than and all balances.

                   Bug fix with financial date being before current year - marked Ch001a

Ch002 - 01/06/18 - Statement Report - by default only printing the first 2 pages. No code change just settings change to Quickreport as listed below -
        Within unit uLedgerReport - go to the settings of the quick report
        Expand the 'PrinterSettings'
        Change 'FirstPage' from 1 to 0
        Change 'LastPage' from 2 to 0

Ch003 - Bug within Enterprise Analysis : This Year Vs. Last Year report which was including nominal accounts that have not be activated or were deleted.
        Added if 'Active' filter to report

Ch004 - Check validation for Bank Account number - customer issues with saving transactions against bank account 0 - specifically Ledger Payments / Receipts

Ch005 & Ch005a -  Checking if a nominal code is used on a jobcard / quote / proforma before deleting. Subsequent bug found and fixed (Ch005a)

Ch006 - Major Development - Making Tax Digital for VAT

        Changes Include -
                1. New DigitalVATForm
                2. New DigitalVAT procedure unit
                3. New DigitalVAT Report Form
                4. Check on Cashbook form if transaction under edit has VAT element processed

        Note : Payment Based Changes introduced later are marked Ch006(P)


Ch007 - Bank Audit Trail Bug Fix where negative transactions were picking up customer / supplier from the wrong side

Ch008 - Bug fix in UpdatePLFigures & UpdateSLFigures

Ch009 - Bug fix relating to Year End issues when Age-Of-Debt code added - checkfornewfields removed & extra fields added into createtable functions

Ch010 - Removed the function where a file called Invoice in the data folder would enable the Invoicer

Ch011 - Updated 'Age of Debt' form to use todays date as opposed to default date when opening form

Ch012 - Bug fix on Cost Per Unit Report where divide by zero would occur in some datsets / enterprise codes

Ch013 - New procedure to delete / empty temporary files on exiting the programme

Ch014 - Changes to VAT Audit Report for UK customers - applies to both MTD & Standard Report (all VAT codes appear on Audit Report & only those set to Inc are included in the 9 box return summary)

Ch015 - Addition of new a new Form & options to 'Close VAT Period' for Irish Customers based on the same routines as MTD without the online submission.

Ch016 - Bug Fix when editing date on a Receipt / Payment the date on the discount line is not updated

Ch017 - Modified Digitial VAT Form & Standard NI VAT form to add in tickbox at bottom to include Exempt VAT Code in Audit Trials for Invoice VAT only
       (user request following on from Ch014 above)

Ch018 - Modified OthForm to disable the year end check box & stop users being able to do a year end within archive data

Ch019 - Fixed bug in Enterprise Reports - This Year vs Last Year when If you change a transaction from one nominal to another in the same enterprise it doesn't update this report

Ch020 - Fixed bug in Bank Import where nominal description field isn't clearing and appearing in next transaction for DD/DC/SO transactions

Ch021 - Fixed bug where year end doesn't delete old carried forward files (e.g. SLFile-1) so they could be overwritten with correct versions causing issues with some spanning reports.

Ch022 - Added new Point In Time Year End functionality

Ch023 - Added prompt to HMRC Return to force user to review Audit Trial Before Submitting Return. Request from GM as users were blindly submitting without checking.

Ch024 - Fixed bug where Customer/Supplier was not being saved correclty for DD/DC/SO transaction from Bank Import (Updated TxWrite)

Ch025 - Addition of CSV exports for Accountants
        Trial balance                                        Complete
        Full nominal audit                                   Complete
        Age of debt customers                                Complete
        Age of debt suppliers                                Complete
        Bank audit trail including stub breakdown            Complete

Ch026 - Added in missing DbiSaveChanges to AllocatedVATDB table - possible fix for issues following user having lines go missing from AllocatedVATDB
      - Found a few other tables in AccsData missing the DbiSaveChanges & updated as well

Ch027 - Added check & prompt to stop users from deleting lines when editing a transaction on the cashbook form (prompts when trying to save or also print an invoice)

Ch028 - Transaction Listing Report Issues - Bug : Reference not always being shown & Improvement : customer wanted Cust / Supp shown on all ledger transactions - added cust / supp column

Ch029 - Bug fix within statement report. Running a report between 2 dates with no transactions the balance picked up is the current balance not the point in time balance

Ch030 - Enterprise Reports bug where enterprise units is used & selecting a single code the unit value was devided by 100

15/01/21 - added check for journals to debtors / creditors control as part of extended Data Integrity Check

Ch031 - Bug fix : fix bug when in Invoice Layouts, click Change, click the X to close the screen, go back into Invoice Layouts, db is still in edit mode. Now cancels the editing on exit.

Ch032 - Added extra option within statements to add comment field on the bottom (as per invoices) to add bank details etc

Ch033 - Added fix for Co-op customers who have FirstTx & FirstYr pointers incorrectly set in SL / PL Files which can upset the FirstTx for the front grid after completing a year end

Ch034 - Statement / Ledger bug fix where the 'Balances or Transactions' filter does not look to see if there were transactions (any with opening balances will be included)
        in last year if the user had selected include last year.

Ch035 - Removed the restriction on the cashbook form stopping Northern Ireland Users changing VAT code while editing for exempt codes

Ch036 - Bug fix for Northern Ireland MTD where purchases do not always get marked as claimed (routine replaced)
*)

interface

implementation

end.
