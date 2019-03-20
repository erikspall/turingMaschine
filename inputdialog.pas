unit inputDialog;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckGroup1: TCheckGroup;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioGroup1: TRadioGroup;
    procedure FormShow(Sender: TObject);
    function ShowDialog():String;
  private

  public

  end;

var
  Form2: TForm2;

implementation
  uses mainForm;
{$R *.lfm}

{ TForm2 }



function TForm2.ShowDialog(): String;
var er:String;
begin
    if inputDialog.Form2.ShowModal = mrOk then
    begin
         if not Checkbox1.Checked then
         begin
         if RadioButton1.Checked then
         begin
              er:='L;';
         end else if RadioButton2.Checked then
         begin
              er:='0;';
         end else er:='R;';

         er:=er+ComboBox1.Items[ComboBox1.ItemIndex]+';';
         er:=er+ComboBox2.Items[ComboBox2.ItemIndex];
          end else er:='~Ende~';
         result:=er;
    end;
end;

procedure TForm2.FormShow(Sender: TObject);
begin

end;

end.

