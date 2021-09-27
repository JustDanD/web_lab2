<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Web Lab 2</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="">
    <!-- <link rel="stylesheet" href="css/style.css"> -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
            integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/react@latest/umd/react.development.js" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/react-dom@latest/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/@material-ui/core@latest/umd/material-ui.development.js"
            crossorigin="anonymous"></script>
    <script src="https://unpkg.com/babel-standalone@latest/babel.min.js" crossorigin="anonymous"></script>
    <!-- Fonts to support Material Design -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"/>
    <!-- Icons to support Material Design -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="scripts/jquery.session.js"></script>
    <style>
        html,
        body {
            height: 100%;
            background-color: #F8F8F8;
        }

        #header {
            background-color: #1946ba;
            display: flex;
            height: 60px;
            justify-content: space-between;
            align-items: center;
            padding-left: 0px;
            padding-right: 0px;
            color: white;
            width: 100%;
        }

        #leftside {
            display: flex;
            height: 60px;
            align-items: center;
            width: 234px;
        }

        #mid {
            text-align: center;
            padding-right: 2%;
            padding-left: 2%;
            margin-left: -40px;
        }

        #rightside {
            display: flex;
            height: 60px;
            align-items: center;
            width: 10%;
        }

        #footer {
            text-align: center;
            padding-bottom: 10px;
        }

        #vertical_wrap {
            height: 100%;
            display: -webkit-flex;
            display: flex;
            flex-direction: column;
            align-content: space-between;
        }

        #horizontal_wrap {
            display: -webkit-flex;
            display: flex;
            flex-grow: 1;
        }

        #coordForm {
            width: 32%;
            padding-right: 1.5%;
        }

        #content {
            display: flex;
        }

        #curStats {
            width: 20%;
            padding-left: 1.5%;
        }

        #graphics {
            width: 44%;
        }
    </style>
</head>

<body>
<script type="text/babel">
    const {
        colors,
        CssBaseline,
        ThemeProvider,
        Typography,
        Container,
        makeStyles,
        createMuiTheme,
        Box,
        SvgIcon,
        Link,
        Icon,
        TextField,
        Grid,
        Button,
        Checkbox,
        FormControlLabel, FormGroup,
        Paper,
        MenuIcon,
        Fab,
        IconButton,
        Menu,
        MenuItem,
        Card,
        CardActions,
        CardContent,
        Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle,
        Tabs, Tab, AppBar, Grow, AddIcon, EditIcon, FavoriteIcon,
        Table, TableContainer, TableHead, TableRow, TableCell, TableBody,
        List, ListItem, ListItemIcon, ListItemText, Divider,
        ButtonGroup, Select, InputLabel, FormControl,
        CircularProgress,

    } = MaterialUI;

    const {
        useState
    } = React;


    // Create a theme instance.
    const theme = createMuiTheme({
        palette: {
            primary: {
                main: '#1946ba',
            },
            secondary: {
                main: '#ec0b43',
            },
            error: {
                main: colors.red.A400,
            },
            background: {
                default: '#fff',
            },
        },
        typography: {
            button: {
                textTransform: 'none',

            }
        },
        MuiTypography: {

            variantMapping: {
                h1: 'h2',
                h2: 'h2',
                h3: 'h2',
                h4: 'h2',
                h5: 'h2',
                h6: 'h2',
                subtitle1: 'h2',
                subtitle2: 'h2',
                body1: 'span',
                body2: 'span',
            },
        },


    });

    function App() {
        const useStyles = makeStyles(theme => ({
            root: {
                margin: theme.spacing(6, 0, 3),
            },
            lightBulb: {
                verticalAlign: 'middle',
                marginRight: theme.spacing(1),
            },
            wrap: {
                backgroundColor: '#F8F8F8',
                height: '100%'
            },
            paper: {
                padding: 30,
                width: '100%'
            },
            contentWrap: {
                width: '100%',
                display: 'flex',
                padding: 20,
                flexGrow: 1

            }
        }));
        const classes = useStyles();
        const [isMobile, setIsMobile] = useState(false);
        const [checked1, setChecked1] = useState(false);
        const [checked2, setChecked2] = useState(false);
        const [checked3, setChecked3] = useState(false);
        const [checked4, setChecked4] = useState(false);
        const [checked5, setChecked5] = useState(false);
        const [selected, setSelected] = useState(0);
        const [x, setX] = useState(-3);
        const [y, setY] = useState(-4);
        const [r, setR] = useState(0);
        const [rows, setRows] = useState([]);
        const [dense, setDense] = useState(false);
        const [success, setSuccess] = useState(0);

        function createElement(id, x, y, r, success, isSuccess) {
            return {id, x, y, r, success, isSuccess};
        }

        const countSuccess = () => {
            let i = 0;
            rows.forEach(element => {
                if (element.isSuccess)
                    i++;
            });
            setSuccess(i);
        };

        const headCells = [
            {id: 'ID', numeric: false, disablePadding: false, label: '№'},
            {id: 'X', numeric: false, disablePadding: false, label: 'X'},
            {id: 'Y', numeric: false, disablePadding: false, label: 'Y'},
            {id: 'R', numeric: false, disablePadding: false, label: 'R'},
            {id: 'SUCCESS', numeric: false, disablePadding: false, label: 'Попадание'},
        ];


        function EnhancedTableHead(props) {
            const {classes, onSelectAllClick, order, orderBy, numSelected, rowCount, onRequestSort} = props;
            const createSortHandler = (property) => (event) => {
                onRequestSort(event, property);
            };

            return (
                <TableHead>
                    <TableRow>
                        {headCells.map((headCell) => (
                            <TableCell
                                key={headCell.id}
                                align={headCell.numeric ? 'right' : 'left'}
                                padding={headCell.disablePadding ? 'none' : 'normal'}
                            >
                                {headCell.label}
                            </TableCell>
                        ))}
                    </TableRow>
                </TableHead>
            );
        }

        function draw() {
            let cnvs = document.getElementById("graphics");
            if (cnvs.getContext) {
                let ctx = cnvs.getContext("2d");
                let radius = cnvs.height / 2 - 15;
                ctx.beginPath();
                ctx.strokeStyle = "black";
                ctx.fillStyle = "#1946ba";
                ctx.moveTo(cnvs.width / 2, cnvs.height / 2 - radius);
                ctx.lineTo(cnvs.width / 2 - radius, cnvs.height / 2);
                ctx.lineTo(cnvs.width / 2, cnvs.height / 2);
                ctx.fill();
                ctx.fillRect(cnvs.width / 2, cnvs.height / 2, radius, radius);
                ctx.arc(cnvs.width / 2, cnvs.height / 2, radius, Math.PI / 2, Math.PI, false);
                ctx.fill();
                //Ось X
                ctx.beginPath();
                ctx.moveTo(0, cnvs.height / 2);
                ctx.lineTo(cnvs.width, cnvs.height / 2);
                ctx.strokeStyle = "#ec0b43";
                ctx.lineWidth = 2;
                ctx.closePath();
                ctx.stroke()
                ctx.fillStyle = "black";
                // ось Y
                ctx.beginPath();
                ctx.moveTo(cnvs.width / 2, 0);
                ctx.lineTo(cnvs.width / 2, cnvs.height);
                ctx.strokeStyle = "#ec0b43";
                ctx.closePath();
                ctx.stroke();
                ctx.font = "10 px Arial"
                ctx.fillText("-R", cnvs.width / 2 - radius, cnvs.height / 2 - 2);
                ctx.fillText("-R/2", cnvs.width / 2 - radius / 2, cnvs.height / 2 - 2);
                ctx.fillText("R", cnvs.width / 2 + radius, cnvs.height / 2 - 2);
                ctx.fillText("R/2", cnvs.width / 2 + radius / 2, cnvs.height / 2 - 2);

                ctx.fillText("-R", cnvs.width / 2 - 15, cnvs.height / 2 + radius);
                ctx.fillText("-R/2", cnvs.width / 2 - 20, cnvs.height / 2 + radius / 2);
                ctx.fillText("R/2", cnvs.width / 2 - 17, cnvs.height / 2 - radius / 2);
                ctx.fillText("R", cnvs.width / 2 - 10, cnvs.height / 2 - radius);
            }
        }

        const getCanvasCoords = (elem) => {
            let box = elem.getBoundingClientRect();
            return {
                top: box.top + pageYOffset,
                left: box.left + pageXOffset,
                right: box.right + pageXOffset,
                bottom: box.bottom + pageYOffset
            };

        }
        const handleClick = (event) => {
            if (r === 0) {
                alert("Не указан R!");
                return;
            }
            let cnvs = document.getElementById("graphics");
            if (cnvs.getContext) {
                let ctx = cnvs.getContext("2d");
                let radius = cnvs.height / 2 - 15;
                let coords = getCanvasCoords(cnvs);
                let mouseX = event.pageX;
                let mouseY = event.pageY;
                ctx.fillStyle = "#ec0b43";
                let coordX = -(cnvs.width / 2 - (mouseX - coords.left) / ((coords.right - coords.left) / cnvs.width)) / radius;
                let coordY = (cnvs.height / 2 - (mouseY - coords.top) / ((coords.bottom - coords.top) / cnvs.height)) / radius;
                setX(r * coordX);
                setY(r * coordY);
                ctx.fillRect((mouseX - coords.left) / ((coords.right - coords.left) / cnvs.width),
                    (mouseY - coords.top) / ((coords.bottom - coords.top) / cnvs.height), 2, 2);

            }
        }
        const drawDot = (x, y, r) => {
            let cnvs = document.getElementById("graphics");
            if (cnvs.getContext) {
                let ctx = cnvs.getContext("2d");
                let radius = cnvs.height / 2 - 15;
                let coords = getCanvasCoords(cnvs);
                ctx.fillStyle = "#ec0b43";
                let coordX = cnvs.width/2 - (x / r * -radius);
                let coordY = cnvs.height / 2 - (y / r * radius);
                ctx.fillRect(coordX, coordY, 2, 2);

            }
        }
        const drawDots = () => {
            rows.forEach(element => {
                drawDot(element.x, element.y, element.r);
            });
        }
        //choose the screen size
        const handleResize = () => {
            if (window.innerWidth < 720) {
                setIsMobile(true)
            } else {
                setIsMobile(false)
            }
        };

        const changeSelected = () => {
            if (selected === 0) {
                setR(0);
                setChecked1(false);
                setChecked2(false);
                setChecked3(false);
                setChecked4(false);
                setChecked5(false);
                return;
            }
            if (selected === 1) {
                setR(1);
                setChecked1(true);
                setChecked2(false);
                setChecked3(false);
                setChecked4(false);
                setChecked5(false);
                return;
            }
            if (selected === 2) {
                setR(2);
                setChecked2(true);
                setChecked1(false);
                setChecked3(false);
                setChecked4(false);
                setChecked5(false);
                return;
            }
            if (selected === 3) {
                setR(3);
                setChecked3(true);
                setChecked2(false);
                setChecked1(false);
                setChecked4(false);
                setChecked5(false);
                return;
            }
            if (selected === 4) {
                setR(4);
                setChecked4(true);
                setChecked2(false);
                setChecked3(false);
                setChecked1(false);
                setChecked5(false);
                return;
            }
            if (selected === 5) {
                setR(5);
                setChecked5(true);
                setChecked2(false);
                setChecked3(false);
                setChecked4(false);
                setChecked1(false);
                return;
            }

        };

        React.useEffect(() => {
            window.addEventListener("resize", handleResize);
            draw(); 
            renderHistory();
        }, []);
        React.useEffect(() => {
            changeSelected();
        }, [selected]);
        React.useEffect(() => {
            countSuccess();
            drawDots();
        }, [rows]);

        const handleSubmit = () => {
            $.ajax({
                url: '${pageContext.request.contextPath}/controller',
                type: 'POST',
                async: true,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({X: x, Y: y, R: r}),
                dataType: 'html',
                success: (res) => {
                    $("#root").replaceWith(res);
                }
            });
        }

        const renderHistory = () => {
            <c:if test="${sessionScope.get('history').size() > 0}">
                let resp = [];
                <c:forEach var="i" begin="0" end="${sessionScope.get('history').size()-4}" step="4">
                    resp.push(createElement(Math.floor(${i/4} + 1), ${sessionScope.get('history').get(i)}, ${sessionScope.get('history').get(i + 1)},
                        ${sessionScope.get('history').get(i + 2)}, "${sessionScope.get('history').get(i + 3)}", ${sessionScope.get('history').get(i + 3) == "Да"}));
                </c:forEach>
                setRows(resp);
                return;
            </c:if>
            setRows([]);
        }

        return (
            <div className={classes.wrap}>
                <div id="vertical_wrap">
                    <div id='header'>
                        <div id='leftside'>
                            <div>
                                <Link color="inherit" href="https://itmo.ru/ru/"><img src="images/itmo_horiz.png"
                                                                                      style={{paddingTop: 0}}
                                                                                      height="60px"
                                                                                      width="inherit"/></Link>
                            </div>
                        </div>
                        <div id="mid">
                            <font size={!isMobile ? 5 : 3}>Лабораторная работа № 2 </font>
                        </div>
                        <div id='rightside'>
                            Вариант: 30212
                        </div>
                    </div>
                    <div id="horizontal_wrap">
                        <div className={classes.contentWrap}>
                            <Paper className={classes.paper}>
                                <div id="content">
                                    <form className={classes.container} id='coordForm' onSubmit={(e) => {
                                        e.preventDefault()
                                        handleSubmit();
                                    }}>
                                        <b>X:</b><br/>
                                        <Button name="X" value="-2" color="secondary" onClick={() => {
                                            setX(-2)
                                        }}>-2</Button>
                                        <Button name="X" value="-1.5" color="secondary" onClick={() => {
                                            setX(-1.5)
                                        }}>-1.5</Button>
                                        <Button name="X" value="-1" color="secondary" onClick={() => {
                                            setX(-1)
                                        }}>-1</Button>
                                        <Button name="X" value="-0.5" color="secondary" onClick={() => {
                                            setX(-0.5)
                                        }}>-0.5</Button>
                                        <Button name="X" value="0" color="secondary" onClick={() => {
                                            setX(0)
                                        }}>0</Button>
                                        <Button name="X" value="0.5" color="secondary" onClick={() => {
                                            setX(0.5)
                                        }}>0.5</Button>
                                        <Button name="X" value="1" color="secondary" onClick={() => {
                                            setX(-1)
                                        }}>1</Button>
                                        <Button name="X" value="1.5" color="secondary" onClick={() => {
                                            setX(1.5)
                                        }}>1.5</Button>
                                        <Button name="X" value="2" color="secondary" onClick={() => {
                                            setX(2)
                                        }}>2</Button>
                                        <br/>
                                        <b>Y:</b><br/>
                                        <TextField id="Y" name="Y" helperText="Float from -5 to 3" variant="outlined"
                                                   color="secondary"
                                                   type="number"
                                                   onBlur={(e) => {
                                                       setY(e.target.value)
                                                   }}
                                                   InputProps={{
                                                       inputProps: {
                                                           max: 3.0, min: -5.0,
                                                           maxLength: 6,
                                                           step:"0.0001"
                                                       }
                                                   }}/>
                                        <br/>
                                        <b>R:</b><br/>
                                        <FormControlLabel
                                            control={<Checkbox checked={checked1} name="R" value="1" onChange={() => {
                                                if (selected === 1)
                                                    setSelected(0);
                                                else
                                                    setSelected(1);
                                            }}/>} label="1" labelPlacement="start"/>
                                        <FormControlLabel
                                            control={<Checkbox checked={checked2} name="R" value="2" onChange={() => {
                                                if (selected === 2)
                                                    setSelected(0);
                                                else
                                                    setSelected(2);
                                            }}/>} label="2" labelPlacement="start"/>
                                        <FormControlLabel
                                            control={<Checkbox checked={checked3} name="R" value="3" onChange={() => {
                                                if (selected === 3)
                                                    setSelected(0);
                                                else
                                                    setSelected(3);
                                            }}/>} label="3" labelPlacement="start"/>
                                        <FormControlLabel
                                            control={<Checkbox checked={checked4} name="R" value="4" onChange={() => {
                                                if (selected === 4)
                                                    setSelected(0);
                                                else
                                                    setSelected(4);
                                            }}/>} label="4" labelPlacement="start"/>
                                        <FormControlLabel
                                            control={<Checkbox checked={checked5} name="R" value="5" onChange={() => {
                                                if (selected === 5)
                                                    setSelected(0);
                                                else
                                                    setSelected(5);
                                            }}/>} label="5" labelPlacement="start"/>
                                        <br/><br/><br/><br/>
                                        <Button color="secondary" type="submit">Отправить</Button>
                                        <Button color="secondary" onClick={() => {
                                            document.getElementById("Y").value = "";
                                            setY(-6);
                                            setX(0);
                                            setSelected(0);
                                        }} style={{marginLeft: 30}}>Сбросить</Button> <br/>
                                        <Button color="secondary" onClick={() => {
                                            window.location.href = 'deprecated.jsp';
                                        }} style={{marginLeft: 7}}>Путешествие в прошлое</Button>
                                    </form>
                                    <canvas onClick={(e) => {
                                        handleClick(e);
                                    }} onDoubleClick={(e) => {
                                                handleClick(e);
                                                handleSubmit();
                                            }} id="graphics"></canvas>
                                    <div id="curStats">
                                        <b>Текущие значения координат и статистика:</b><br/>
                                        <b>X: </b>
                                        <br/><TextField size="small" readOnly color="secondary" variant="outlined"
                                                        value={x}/>
                                        <br/>
                                        <b>Y: </b>
                                        <br/><TextField size="small" readOnly color="secondary" variant="outlined"
                                                        value={y}/>
                                        <br/>
                                        <b>R:</b>
                                        <br/><TextField size="small" readOnly color="secondary" variant="outlined"
                                                        value={r}/>
                                        <b>Количество проверок:</b>
                                        <br/><TextField size="small" readOnly color="secondary" variant="outlined"
                                                        value={rows.length}/>
                                        <b>Количество попаданий:</b>
                                        <br/><TextField size="small" readOnly color="secondary" variant="outlined"
                                                        value={success}/>

                                    </div>
                                </div>
                                <br/><br/>
                                <div id="table">
                                    <TableContainer>
                                        <Table
                                            className={classes.table}
                                            aria-labelledby="tableTitle"
                                            size={dense ? 'small' : 'medium'}
                                            aria-label="enhanced table"
                                        >
                                            <EnhancedTableHead
                                                classes={classes}
                                                rowCount={rows.length}
                                            />
                                            <TableBody>
                                                {rows.map((row, index) => {
                                                    return (
                                                        <TableRow
                                                            hover
                                                            tabIndex={-1}
                                                            key={row.id}
                                                        >
                                                            <TableCell
                                                                style={{color: row.isSuccess ? colors.green.A400 : colors.red.A400}}>{row.id}</TableCell>
                                                            <TableCell
                                                                style={{color: row.isSuccess ? colors.green.A400 : colors.red.A400}}>{row.x}</TableCell>
                                                            <TableCell
                                                                style={{color: row.isSuccess ? colors.green.A400 : colors.red.A400}}>{row.y}</TableCell>
                                                            <TableCell
                                                                style={{color: row.isSuccess ? colors.green.A400 : colors.red.A400}}>{row.r}</TableCell>
                                                            <TableCell
                                                                style={{color: row.isSuccess ? colors.green.A400 : colors.red.A400}}>{row.success}</TableCell>
                                                        </TableRow>
                                                    );
                                                })}
                                            </TableBody>
                                        </Table>
                                    </TableContainer>
                                </div>
                            </Paper>
                        </div>
                    </div>
                    <div id="footer">
                        <Typography variant="body2" color="textSecondary" align="center">
                            {'Powered by: '}
                            <Link color="inherit" href="https://vk.com/dpimenov98">
                                Pimenov Danila P3230
                            </Link>{' '} <br/>
                            <Link color="inherit" href="https://github.com/JustDanD/web_lab1">
                                GitHub
                            </Link>{' '}
                        </Typography>
                    </div>

                </div>
            </div>
        );
    }

    ReactDOM.render(
        <ThemeProvider theme={theme}>
            {/* CssBaseline kickstart an elegant, consistent, and simple baseline to build upon. */}
            <CssBaseline/>
            <App/>
        </ThemeProvider>,
        document.querySelector('#root'),
    );
</script>
<div onload="draw();" id="root" style="height: 100%;"></div>


</body>

</html>
