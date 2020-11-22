/*
*
*  Under GPL License
*
*/

#ifndef SERIALPORT_H
#define SERIALPORT_H

#include <QQuickItem>
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>

class SerialPort : public QQuickItem
{
	Q_OBJECT
public:
	SerialPort(QQuickItem *parent = 0);
    Q_INVOKABLE QStringList getAvailablePorts();
    Q_INVOKABLE void setup(const QString portName = "COM1", int baudRate = 9600);
	Q_INVOKABLE bool open(QFile::OpenMode mode = QIODevice::ReadWrite);
	Q_INVOKABLE void close();
	Q_INVOKABLE QString	read(qint64 maxSize = 4096);
    Q_INVOKABLE QByteArray	readData();
	Q_INVOKABLE QString	readLine(qint64 maxSize = 4096);
	Q_INVOKABLE bool	write(QString s);
	Q_INVOKABLE bool	writeLine(QString s);
    Q_INVOKABLE float getTemperatureAt(int index);

	/*Async+*/

signals:

public slots:

private:
	QString	serialEOL;
	QSerialPort	m_serial;
    QStringList m_availablePorts;
    float m_temperature[8];
};

#endif // SERIALPORT_H
