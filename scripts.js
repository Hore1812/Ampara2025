$(document).ready(function() {
    // Inicializar DataTable
    $('#tablaLiquidaciones').DataTable({
        language: {
            url: 'https://cdn.datatables.net/plug-ins/1.11.5/i18n/es-ES.json'
        },
        dom: '<"top"lf>rt<"bottom"ip>',
        responsive: true
    });
    
    // Limpiar filtros
$('#limpiarFiltros').click(function(e) {
    e.preventDefault(); // Prevenir cualquier comportamiento por defecto del botón
    // Opcional: Resetear visualmente los campos antes de redirigir, 
    // aunque la redirección ya mostrará los campos vacíos.
    $('#filtrosForm').find('select').val(''); 
    // O podrías usar: $('#filtrosForm')[0].reset();

    // Redirigir a la página principal sin parámetros de filtro
    window.location.href = 'index.php';
});
    // Modal ver colaboradores
    $(document).on('click', '.ver-colaboradores', function() {
        const idLiquidacion = $(this).data('id');
        $('#tituloLiquidacion').text(idLiquidacion);
        
        $.ajax({
            url: 'ajax/obtener_colaboradores.php',
            method: 'POST',
            data: { idliquidacion: idLiquidacion },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    let html = '';
                    let totalPorcentaje = 0;
                    let totalCalculo = 0;
                    
                    response.data.forEach(colab => {
                        html += `
                            <tr>
                                <td>${colab.ID}</td>
                                <td>${colab.COLABORADOR}</td>
                                <td>${colab.Porcentaje}%</td>
                                <td>${colab.CALCULO}</td>
                                <td>${colab.COMENTARIO}</td>
                            </tr>
                        `;
                        
                        totalPorcentaje += parseInt(colab.Porcentaje);
                        totalCalculo += parseFloat(colab.CALCULO);
                    });
                    
                    $('#tablaColaboradores').html(html);
                    $('#totalPorcentaje').text(totalPorcentaje + '%');
                    $('#totalCalculo').text(totalCalculo.toFixed(2));
                    
                    $('#modalColaboradores').modal('show');
                } else {
                    alert(response.message);
                }
            },
            error: function() {
                alert('Error al cargar los colaboradores');
            }
        });
    });
    
    // Modal eliminar liquidación
    $(document).on('click', '.eliminar-liquidacion', function() {
        const idLiquidacion = $(this).data('id');
        $('#idEliminar').val(idLiquidacion);
        $('#modalEliminar').modal('show');
    });
    

  // Modal Registrar liquidación
    $(document).on('click', '.guardar-liquidacion', function() {
        // const idLiquidacion = $(this).data('id');
        // $('#idEliminar').val(idLiquidacion);
        $('#modalConfirmar').modal('show');
    });
// Modal Guardar cambios liquidación
    $(document).on('click', '.guardar-cambios', function() {
        // const idLiquidacion = $(this).data('id');
        // $('#idEliminar').val(idLiquidacion);
        $('#modalOk').modal('show');
    });




    // Modal historico colaborador
    $('#colaborador').change(function() {
        const idColaborador = $(this).val();
        const nombreColaborador = $(this).find('option:selected').text();
        
        if (idColaborador) {
            $('#tituloColaborador').text(nombreColaborador);
            cargarHistoricoColaborador(idColaborador);
            $('#modalHistoricoColaborador').modal('show');
        }
    });
    
   // Filtrar historico colaborador
$('#filtrosColaboradorForm').submit(function(e) {
    e.preventDefault();
    const idColaborador = $('#modalHistoricoColaborador').data('idColaboradorActual'); // Obtener de data attribute
    const anio = $('#anioColab').val();
    const mes = $('#mesColab').val();
    const estado = $('#estadoColab').val(); // <--- Obtener el valor del nuevo select de estado
    
    if (idColaborador) { 
        cargarHistoricoColaborador(idColaborador, anio, mes, estado); // <--- Pasar el nuevo parámetro estado
    } else {
        // console.error("No se encontró idColaborador para el filtro de la modal.");
    }
});

// Guardar el idColaborador cuando se abre la modal de histórico
$('#colaborador').change(function() {
    const idColaborador = $(this).val();
    const nombreColaborador = $(this).find('option:selected').text();
    
    if (idColaborador) {
        $('#tituloColaborador').text(nombreColaborador);
        $('#modalHistoricoColaborador').data('idColaboradorActual', idColaborador); // Guardar ID
        cargarHistoricoColaborador(idColaborador, $('#anioColab').val(), $('#mesColab').val(), $('#estadoColab').val());
        $('#modalHistoricoColaborador').modal('show');
    } else {
        $('#modalHistoricoColaborador').removeData('idColaboradorActual'); // Limpiar si no hay selección
    }
});
    
    // Cerrar modal y resetear select colaborador
    $('#modalHistoricoColaborador').on('hidden.bs.modal', function() {
        $('#colaborador').val('');
    });
    
    // Funcionalidad para registrar.php y editar.php
    if ($('#formLiquidacion').length) {
        // Habilitar select cliente cuando se selecciona tipo hora
        $('#tipohora').change(function() {
            const tipoHora = $(this).val();
            
            if (tipoHora) {
                $('#cliente').prop('disabled', false);
                
                $.ajax({
                    url: 'ajax/obtener_clientes.php',
                    method: 'POST',
                    data: { tipohora: tipoHora },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            let options = '<option value="">Seleccionar</option>';
                            
                            response.data.forEach(cliente => {
                                // Extraer el nombre del cliente (después del " – ")
                                const parts = cliente.CLIENTE.split(' – ');
                                const nombreCliente = parts.length > 1 ? parts[1] : cliente.CLIENTE;
                                
                                options += `<option value="${cliente.idcontratocli}">${nombreCliente}</option>`;
                            });
                            
                            $('#cliente').html(options);
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function() {
                        alert('Error al cargar los clientes');
                    }
                });
            } else {
                $('#cliente').prop('disabled', true).html('<option value="">Seleccionar</option>');
                $('#lider').val('');
                $('#idlider').val('');
            }
        });
        
        // Obtener líder cuando se selecciona cliente
        $('#cliente').change(function() {
            const idContrato = $(this).val();
            
            if (idContrato) {
                $.ajax({
                    url: 'ajax/obtener_lider.php',
                    method: 'POST',
                    data: { idcontrato: idContrato },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            $('#lider').val(response.data.nombrecorto);
                            $('#idlider').val(response.data.lider);
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function() {
                        alert('Error al cargar el líder');
                    }
                });
            } else {
                $('#lider').val('');
                $('#idlider').val('');
            }
        });
        
        // Obtener encargado cuando se selecciona tema
        $('#tema').change(function() {
            const idTema = $(this).val();
            
            if (idTema) {
                $.ajax({
                    url: 'ajax/obtener_encargado.php',
                    method: 'POST',
                    data: { idtema: idTema },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            $('#encargado').val(response.data.nombrecorto);
                            $('#idencargado').val(response.data.idempleado);
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function() {
                        alert('Error al cargar el encargado');
                    }
                });
            } else {
                $('#encargado').val('');
                $('#idencargado').val('');
            }
        });
        
        // Mostrar/ocultar sección distribución según estado
        $('#estado').change(function() {
            if ($(this).val() === 'Completo') {
                $('#seccionDistribucion').slideDown();
                
                // Si no hay colaboradores, agregar uno por defecto
                if ($('.colaborador-row').length === 0) {
                    agregarColaborador();
                }
            } else {
                $('#seccionDistribucion').slideUp();
            }
        });
        
        // Agregar colaborador
        $('#agregarColaborador').click(function() {
            if ($('.colaborador-row').length < 6) {
                agregarColaborador();
            } else {
                alert('Máximo 6 colaboradores permitidos');
            }
        });
        
        // Eliminar colaborador
        $(document).on('click', '.eliminar-colaborador', function() {
            $(this).closest('.colaborador-row').remove();
            actualizarIndicesColaboradores();
            actualizarOpcionesColaboradores();
        });
        
        // Validar suma de porcentajes antes de enviar
        $('#formLiquidacion').submit(function(e) {
            if ($('#estado').val() === 'Completo') {
                let total = 0;
                
                $('.porcentaje-input').each(function() {
                    total += parseInt($(this).val()) || 0;
                });
                
                if (total !== 100) {
                    e.preventDefault();
                    alert(`La suma total de porcentajes debe ser exactamente 100%. Actual: ${total}%`);
                }
            }
        });
        
        // Modal cancelar
        $('#btnCancelar').click(function() {
            $('#modalCancelar').modal('show');
        });
        
          
        // Modal Confirmar-Editar
        $('#btnGuardar').click(function() {
            $('#modalOk').modal('show');
        });
        
    }
    
    // Funciones auxiliares
    function cargarHistoricoColaborador(idColaborador, anio = null, mes = null, estado = null) { // <--- Nuevo parámetro estado
    $.ajax({
        url: 'ajax/obtener_historico_colaborador.php',
        method: 'POST',
        data: { 
            idcolaborador: idColaborador,
            anio: anio,
            mes: mes,
            estado: estado // <--- Enviar el nuevo parámetro estado
        },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                let html = '';
                let totalAcumulado = 0; // Se calculará con DataTable
                
                response.data.forEach(item => {
                    html += `
                        <tr>
                            <td>${item.ID}</td>
                            <td>${formatDate(item.FECHA)}</td>
                            <td>${item.CLIENTE}</td>
                            <td>${item.TEMA}</td>
                            <td>${item.ASUNTO}</td>
                            <td>${item.MOTIVO}</td>
                            <td>${item.LIDER}</td>
                            <td>${item.ENCARGADO}</td>
                            <td>${item.ESTADO}</td>
                            <td>${item.ACUMULADO}</td>
                            <td>${item.TIPOHORA}</td>
                        </tr>
                    `;
                    // totalAcumulado += parseFloat(item.ACUMULADO) || 0; // No sumar aquí, lo hará DT
                });
                
                var tablaHistorico = $('#tablaHistoricoColaborador');
                // Destruir DataTable existente antes de rellenar y reinicializar
                if ($.fn.DataTable.isDataTable(tablaHistorico)) {
                    tablaHistorico.DataTable().destroy();
                }
                
                tablaHistorico.find('tbody').html(html); // Llenar el tbody con los nuevos datos
                
                // Re-inicializar DataTable con el footerCallback para los totales
                tablaHistorico.DataTable({
                    language: {
                        url: 'https://cdn.datatables.net/plug-ins/1.11.5/i18n/es-ES.json'
                    },
                    dom: '<"top"lf>rt<"bottom"ip>',
                    responsive: true,
                    destroy: true, // Necesario si se va a reinicializar con frecuencia
                    data: response.data, // Pasar los datos directamente a DataTables
                    columns: [ // Definir las columnas para que DataTables sepa qué mostrar
                        { data: 'ID' },
                        { data: 'FECHA', render: function(data){ return formatDate(data); }},
                        { data: 'CLIENTE' },
                        { data: 'TEMA' },
                        { data: 'ASUNTO' },
                        { data: 'MOTIVO' },
                        { data: 'LIDER' },
                        { data: 'ENCARGADO' },
                        { data: 'ESTADO' },
                        { data: 'ACUMULADO', className: 'dt-body-right' }, // Alinear a la derecha
                        { data: 'TIPOHORA' }
                    ],
                    footerCallback: function(row, data, start, end, display) {
                        var api = this.api();
                        
                        // Suma de la columna ACUMULADO (índice 9) para la página actual
                        var sumAcumulado = api
                            .column(9, { page: 'current' })
                            .data()
                            .reduce(function (a, b) {
                                return parseFloat(a) + parseFloat(b);
                            }, 0);
                        
                        // Actualizar el footer
                        $('#totalAcumuladoHistorico').text(sumAcumulado.toFixed(2));

                        var pageInfo = api.page.info();
                        $('#conteoRegistrosHistorico').text(`Mostrando ${pageInfo.recordsDisplay} de ${pageInfo.recordsTotal} registros`);
                    }
                });

            } else {
                alert(response.message);
                $('#tablaHistoricoColaborador tbody').html('<tr><td colspan="11" class="text-center">Error al cargar datos.</td></tr>');
                 if ($.fn.DataTable.isDataTable('#tablaHistoricoColaborador')) {
                    $('#tablaHistoricoColaborador').DataTable().clear().draw(); // Limpiar tabla si hay error
                 }
                 $('#totalAcumuladoHistorico').text('0.00');
                 $('#conteoRegistrosHistorico').text('Mostrando 0 de 0 registros');
            }
        },
        error: function() {
            alert('Error de conexión al cargar el histórico del colaborador.');
            $('#tablaHistoricoColaborador tbody').html('<tr><td colspan="11" class="text-center">Error de conexión.</td></tr>');
            if ($.fn.DataTable.isDataTable('#tablaHistoricoColaborador')) {
                $('#tablaHistoricoColaborador').DataTable().clear().draw();
            }
            $('#totalAcumuladoHistorico').text('0.00');
            $('#conteoRegistrosHistorico').text('Mostrando 0 de 0 registros');
        }
    });
}
    
    function formatDate(dateString) {
        const date = new Date(dateString);
        return date.toLocaleDateString('es-ES');
    }
    
    function agregarColaborador() {
        const index = $('.colaborador-row').length + 1;
        
        $.ajax({
            url: 'ajax/obtener_colaboradores_disponibles.php',
            method: 'POST',
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    let options = '<option value="">Seleccionar</option>';
                    
                    response.data.forEach(colab => {
                        options += `<option value="${colab.ID}" data-nombre="${colab.COLABORADOR}">${colab.COLABORADOR}</option>`;
                    });
                    
                    const html = `
                        <div class="row mb-2 colaborador-row" data-index="${index}">
                            <div class="col-md-4">
                                <label class="form-label">Colaborador ${index}</label>
                                <select name="colaboradores[${index}][id]" class="form-select colaborador-select" required>
                                    ${options}
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Porcentaje</label>
                                <input type="number" name="colaboradores[${index}][porcentaje]" 
                                       class="form-control porcentaje-input" min="1" max="100" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Comentario</label>
                                <input type="text" name="colaboradores[${index}][comentario]" 
                                       class="form-control">
                            </div>
                            <div class="col-md-2 d-flex align-items-end">
                                <button type="button" class="btn btn-danger btn-sm eliminar-colaborador">
                                    <i class="fas fa-trash"></i> Eliminar
                                </button>
                            </div>
                        </div>
                    `;
                    
                    $('#contenedorColaboradores').append(html);
                    actualizarOpcionesColaboradores();
                } else {
                    alert(response.message);
                }
            },
            error: function() {
                alert('Error al cargar los colaboradores disponibles');
            }
        });
    }
    
    function actualizarIndicesColaboradores() {
        $('.colaborador-row').each(function(index) {
            const newIndex = index + 1;
            $(this).attr('data-index', newIndex);
            $(this).find('label').text(`Colaborador ${newIndex}`);
            
            // Actualizar los nombres de los inputs
            $(this).find('select').attr('name', `colaboradores[${newIndex}][id]`);
            $(this).find('.porcentaje-input').attr('name', `colaboradores[${newIndex}][porcentaje]`);
            $(this).find('input[type="text"]').attr('name', `colaboradores[${newIndex}][comentario]`);
        });
    }
    
    function actualizarOpcionesColaboradores() {
        const colaboradoresSeleccionados = [];
        
        // Obtener IDs de colaboradores ya seleccionados
        $('.colaborador-select').each(function() {
            const selectedId = $(this).val();
            if (selectedId) {
                colaboradoresSeleccionados.push(selectedId);
            }
        });
        
        // Deshabilitar opciones ya seleccionadas en otros selects
        $('.colaborador-select').each(function() {
            const currentSelect = $(this);
            const currentSelectedId = currentSelect.val();
            
            currentSelect.find('option').each(function() {
                const option = $(this);
                const optionId = option.val();
                
                if (optionId && optionId !== currentSelectedId && colaboradoresSeleccionados.includes(optionId)) {
                    option.prop('disabled', true);
                } else {
                    option.prop('disabled', false);
                }
            });
        });
    }
    
    // Inicializar eventos para actualizar opciones de colaboradores
    $(document).on('change', '.colaborador-select', function() {
        actualizarOpcionesColaboradores();
    });
    // Al final de $(document).ready()
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
   
});