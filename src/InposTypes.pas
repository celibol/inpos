unit InposTypes;

interface

uses
	Windows, Messages, SysUtils, Classes;


{$ifndef INPOSEXT_TYPES}
{$define INPOSEXT_TYPES}

{$HPPEMIT '#include <stdint.h>'}

{$ifdef __GNUC__}
const stdcall __attribute__((stdcall))
{$endif}

const InposNoError = 0;
const InposNotInitializedError	= 1;
const InposConnectionError	= 2;
const InposNullArgumentError	= 3;
const InposInvalidArgumentError	= 4;
const InposMessageParsingError	= 5;
const InposInvalidEcrStateError	= 6;
const InposInvalidSaleStateError	= 7;
const InposInvalidOperationError	= 8;
const InposNoPrinterPaperError	= 9;
const InposGmp3PairingError	= 10;
const InposGmp3EncryptionError	= 11;
const InposGmp3PacketError	= 12;
const InposGmp3ApplicationHashError	= 13;
const InposExternalPrinterError	= 14;
const InposReportPrintingError	= 15;
const InposPayloadSizeError	= 16;
const InposExtErrorEnd	= 17;

type
	InposExtError = InposNoError..InposExtErrorEnd;

	{$EXTERNALSYM InposExtError}

const InposNoErrorDetail = 0;
const InposConnectionErrorBegin       = InposConnectionError shl 8;
const InposNotConnectedToDevice       = InposConnectionErrorBegin;
const InposAddressInUseError	= 4;
const InposHostNotFoundError	= 5;
const InposRemoteHostClosedError	= 6;
const InposSocketAccessError	= 7;
const InposSocketTimeoutError	= 8;
const InposSocketResourceError	= 9;
const InposSocketConnectionRefusedError	= 10;
const InposOtherSocketError	= 11;
const InposInvalidHandleError	= 12;
const InposConnectionErrorEnd	= 13;
const InposNullArgumentErrorBegin     = InposNullArgumentError shl 8;
const InposNullEcrSerialNo            = InposNullArgumentErrorBegin;
const InposNullIpAddress	= 17;
const InposNullEcrState	= 18;
const InposNullSaleState	= 19;
const InposNullSaleTotals	= 20;
const InposNullSaleReceipt	= 21;
const InposNullSaleItem	= 22;
const InposNullMultipleSaleItems	= 23;
const InposNullInvoiceData	= 24;
const InposNullAcquirerIds	= 25;
const InposNullAcquirerIdsSize	= 26;
const InposNullZNo	= 27;
const InposNullSeconds	= 28;
const InposNullPrinterTextEncoding	= 29;
const InposNullPrinterText	= 30;
const InposNullPrinterTextFormat	= 31;
const InposNullSaleLimit	= 32;
const InposNullCashierName	= 33;
const InposNullBlockedFlag	= 34;
const InposNullSaleType	= 35;
const InposNullHandle	= 36;
const InposNullAmounts	= 37;
const InposNullAmountsSize	= 38;
const InposNullVatData	= 39;
const InposNullExternalPrinterBuffer	= 40;
const InposNullBuffer	= 41;
const InposNullSize	= 42;
const InposNullArgumentErrorEnd	= 43;
const InposInvalidArgumentErrorBegin  = InposInvalidArgumentError shl 8;
const InposInvalidEcrSerialNoLength   = InposInvalidArgumentErrorBegin;
const InposInvalidIpAddress	= 47;
const InposInvalidPort	= 48;
const InposInvalidCustomerId	= 49;
const InposInvalidCustomerTaxNo	= 50;
const InposInvalidItemUnitPrice	= 51;
const InposInvalidItemSection	= 52;
const InposInvalidDiscountRate	= 53;
const InposInvalidDiscountAmount	= 54;
const InposInvalidItemUnit	= 55;
const InposInvalidMultipleItemCount	= 56;
const InposInvalidInvoiceType	= 57;
const InposInvalidCustomerNoType	= 58;
const InposInvalidSlipCount	= 59;
const InposInvalidInvoiceNo	= 60;
const InposInvalidReceiptNo	= 61;
const InposInvalidZNo	= 62;
const InposInvalidPrinterTextEncoding	= 63;
const InposInvalidPaymentAmount	= 64;
const InposInvalidEmptyLineCount	= 65;
const InposInvalidBufferLength	= 66;
const InposInvalidSaleType	= 67;
const InposInvalidExternalPrinterBufferSize	= 68;
const InposInvalidDate	= 69;
const InposInvalidArgumentErrorEnd	= 70;
const InposGmp3PairingErrorBegin = InposGmp3PairingError shl 8;
const InposGmp3PairingConnectionError = InposGmp3PairingErrorBegin;
const InposGmp3PairingCertificateError	= 74;
const InposGmp3PairingChecksumError	= 75;
const InposGmp3PairingErrorEnd	= 76;

type
	InposExtErrorDetail = InposNoErrorDetail..InposGmp3PairingErrorEnd;

	{$EXTERNALSYM InposExtErrorDetail}

const InposEcrInitialization = 0;
const InposEcrIdle	= 1;
const InposEcrNotUsable	= 2;
const InposEcrError	= 3;
const InposEcrLogin	= 4;
const InposEcrSale	= 5;
const InposEcrSaleWithInvoice	= 6;
const InposEcrMainMenu	= 7;
const InposEcrReports	= 8;
const InposEcrZReportRequired	= 9;
const InposEcrPrintingMerchantSlip	= 10;
const InposEcrInsertedCardCheck	= 11;
const InposEcrPaymentApplicationActive	= 12;
const InposEcrSaleWithCardPaymentCanceled	= 13;

type
	InposEcrState = InposEcrInitialization..InposEcrSaleWithCardPaymentCanceled;

	{$EXTERNALSYM InposEcrState}

const InposSaleIdle = 0;
const InposSaleWaitingForInput	= 1;
const InposSaleWaitingCancelLastItemResponse	= 2;
const InposSaleWaitingCancelSaleResponse	= 3;
const InposSaleWaitingForSection	= 4;
const InposSaleWaitingForCustomerId	= 5;
const InposSaleWaitingForTransactionCompleted	= 6;
const InposSaleLimitReachedWithLastItem	= 7;
const InposSaleLimitReachedWithAddedAmount	= 8;
const InposSaleUndefinedPluItem	= 9;
const InposSaleInvalidSectionOfPluItem	= 10;
const InposSaleInvalidVatRateOfPluItem	= 11;
const InposSaleUndefinedSection	= 12;
const InposSaleUndefinedVatRate	= 13;
const InposSaleInvalidAmount	= 14;
const InposSaleDataFinalized	= 15;

type
	InposEcrSaleState = InposSaleIdle..InposSaleDataFinalized;

	{$EXTERNALSYM InposEcrSaleState}

const SaleWithReceiptType	= 0;
const SaleWithInvoiceType	= 1;
const SaleWithMealCardType	= 2;
const AdvancePaymentType	= 3;

type
	InposSaleType = SaleWithReceiptType..AdvancePaymentType;

	{$EXTERNALSYM InposSaleType}

const Quantity = 0;
const Gram	= 1;
const Kilogram	= 2;
const Tonne	= 3;
const Milliliter	= 4;
const Liter	= 5;
const Meter	= 6;
const Kilometer	= 7;

type
	TUnit = Quantity..Kilometer;

	{$EXTERNALSYM TUnit}

type
  uint64_t = UInt64;
  {$EXTERNALSYM uint64_t}

  uint32_t = Cardinal;
  {$EXTERNALSYM uint32_t}

  int32_t = Longint;
  {$EXTERNALSYM int32_t}

  uint8_t = Byte;
  {$EXTERNALSYM uint8_t}

  uint16_t = Word;
  {$EXTERNALSYM uint16_t}

	InposEcrSaleItem = record
		unitPrice: uint64_t;
		multiplier: uint32_t;
		discountRate: int32_t;
		discountAmount: uint64_t;
		name : array[0..52] of byte;
		section: byte;
		munit: integer;
	end;
	TInposEcrSaleItem = InposEcrSaleItem;
  PInposEcrSaleItem = ^TInposEcrSaleItem;
	{$EXTERNALSYM TInposEcrSaleItem}


const MAX_SALE_ITEM_COUNT = 10;
{$EXTERNALSYM MAX_SALE_ITEM_COUNT}
type
	InposEcrMultipleSaleItems = record
		count: uint16_t;
		items : array[0..MAX_SALE_ITEM_COUNT-1] of  TInposEcrSaleItem;
	end;
	TInposEcrMultipleSaleItems = InposEcrMultipleSaleItems;
  PInposEcrMultipleSaleItems = ^TInposEcrMultipleSaleItems;
	{$EXTERNALSYM TInposEcrMultipleSaleItems}


type
	InposEcrVatData = record
		vatRates : array[0..7] of  uint32_t;   //!<  %8 -> 800
		vatAmounts : array[0..7] of  uint64_t; //!<  12.50 -> 1250
		amounts : array[0..7] of  uint64_t;    //!<  12.50 -> 1250
	end;
	TInposEcrVatData = InposEcrVatData;
	{$EXTERNALSYM TInposEcrVatData}


type
	InposEcrSaleTotals = record
		totalAmount: uint64_t;
		totalVat: uint64_t;
		amountToPay: uint64_t;
		cashPaymentAmount: uint64_t;
		creditCardPaymentAmount: uint64_t;
		itemCount: uint32_t;
	end;
	TInposEcrSaleTotals = InposEcrSaleTotals;
  PInposEcrSaleTotals = ^TInposEcrSaleTotals;
	{$EXTERNALSYM TInposEcrSaleTotals}


type
	InposSaleReceipt = record
		receiptNo: uint32_t;
		zNo: uint32_t;
		eruNo: uint32_t;
		dateTime: uint32_t;
	end;
	TInposSaleReceipt = InposSaleReceipt;
	{$EXTERNALSYM TInposSaleReceipt}


const Id = 0;
const TaxNo	= 1;

type
	CustomerNoType = Id..TaxNo;

	{$EXTERNALSYM CustomerNoType}

const Invoice = 0;
const EInvoice	= 1;
const EArchiveInvoice	= 2;

type
	InvoiceType = Invoice..EArchiveInvoice;

	{$EXTERNALSYM InvoiceType}

type
	InposInvoiceData = record
		invoiceType: InvoiceType;
		noType: CustomerNoType;
		customerNo : array[0..110] of  char;
		invoiceNo : array[0..160] of  char;
		slipCount: uint32_t;
		printDeliveryNote: uint32_t;
	end;
	TInposInvoiceData = InposInvoiceData;
	{$EXTERNALSYM TInposInvoiceData}

{$endif}	// INPOSEXT_TYPES

implementation

end.

