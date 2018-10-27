unit inputDialogforTM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,Buttons;

type

  { TForm2 }

  TForm2 = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;


    procedure FormCreate(Sender: TObject);

  private

  public
     var WhatToWrite:Char;
    WhereToGo:Integer;
    resu:Boolean;
    function Execute:Boolean;
    procedure jaMoin;
  end;

var
  Form2: TForm2;

implementation

uses tMaschine;

{$R *.lfm}

{ TForm2 }

function TForm2.Execute: Boolean;
Var i:Integer;
begin
  ComboBox1.Items.Clear;
  for i:=1 to Form1.StringGrid1.ColCount-1 do
  begin
     ComboBox1.Items.Add(Form1.StringGrid1.Cells[i,0]);
  end;
  ComboBox1.ItemIndex:=Form1.StringGrid1.Col-1;
  //ComboBox1.SelText:=ComboBox1.Items.Text[Form1.Strin];
  RadioButton2.Checked:=true;
  Result := (ShowModal = mrOk);



  WhatToWrite:=ComboBox1.Items[Form1.StringGrid1.Col-1][1];
  if RadioButton1.Checked then wheretogo:=-1;
  if RadioButton2.checked then wheretogo:=0;
  if RadioButton3.checked then wheretoGo:=1;

end;

procedure TForm2.FormCreate(Sender: TObject);
begin

end;

procedure TForm2.jaMoin;
begin
   resu := (ShowModal = mrOk);
  ComboBox1.Items.Clear;
  for i:=1 to Form1.StringGrid1.ColCount-1 do
  begin
     ComboBox1.Items.Add(Form1.StringGrid1.Cells[i,0]);
  end;
  ComboBox1.ItemIndex:=0;
  WhatToWrite:=ComboBox1.SelText[1];
  if RadioButton1.Checked then wheretogo:=-1;
  if RadioButton2.checked then wheretogo:=0;
  if RadioButton3.checked then wheretoGo:=1;
end;

end.

