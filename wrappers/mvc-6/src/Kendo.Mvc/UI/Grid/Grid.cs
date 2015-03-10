﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using Kendo.Mvc.Extensions;
using Microsoft.AspNet.Mvc;
using Microsoft.AspNet.Mvc.ModelBinding;
using Microsoft.AspNet.Mvc.Rendering;
using Microsoft.Framework.DependencyInjection;

namespace Kendo.Mvc.UI
{
	/// <summary>
	/// The server side wrapper for Kendo UI Grid
	/// </summary>
	/// <typeparam name="T"></typeparam>
	public partial class Grid<T> : WidgetBase, IGridColumnContainer<T>
		where T : class
	{
		private readonly static int DEFAULT_COLUMN_RESIZE_HANDLE_WIDTH = 3;

		public Grid(ViewContext viewContext) : base(viewContext)
		{
			//DataKeys = new List<IDataKey>();			

			Editable = new GridEditableSettings<T>(this)
			{
				//PopUp = new Window(viewContext, Initializer)
				//{
				//	Modal = true,
				//	Draggable = true
				//}
			};

			DataSource = new DataSource(ModelMetadataProvider)
			{
				Type = DataSourceType.Server,
				ServerAggregates = true,
				ServerFiltering = true,
				ServerGrouping = true,
				ServerPaging = true,
				ServerSorting = true
			};

			DataSource.ModelType(typeof(T));
		}

		[Activate]
		public IModelMetadataProvider ModelMetadataProvider
		{
			get;
			set;
		}

		[Activate]
		public IScopedInstance<ActionBindingContext> ActionBindingContext
		{
			get;
			set;
		}

		[Activate]
		public IUrlGenerator UrlGenerator
		{
			get;
			set;
		}
		

		public DataSource DataSource
		{
			get;
			private set;
		}

		private string clientRowTemplate;

        public string ClientRowTemplate
		{
			get
			{
				return clientRowTemplate;
			}
			set
			{
				clientRowTemplate = WebUtility.HtmlDecode(value);
			}
		}

		private string clientAltRowTemplate;

		public string ClientAltRowTemplate
		{
			get
			{
				return clientAltRowTemplate;
			}
			set
			{
				clientAltRowTemplate = WebUtility.HtmlDecode(value);
			}
		}

		public string ClientDetailTemplateId
		{
			get;
			set;
		}

		public int ColumnResizeHandleWidth
		{
			get;
			set;
		}
		= DEFAULT_COLUMN_RESIZE_HANDLE_WIDTH;

		public bool AutoGenerateColumns
		{
			get;
			set;
		} = true;

		public GridEditableSettings<T> Editable { get; }

		public GridToolBarSettings ToolBar { get; } = new GridToolBarSettings();

		/// <summary>
		/// Gets the selection configuration
		/// </summary>
		public GridSelectableSettings Selectable { get; } = new GridSelectableSettings();

		/// <summary>
		/// Gets the column menu configuration.
		/// </summary>
		public GridColumnMenuSettings ColumnMenu { get; } = new GridColumnMenuSettings();

		/// <summary>
		/// Gets the filtering configuration.
		/// </summary>
		public GridFilterableSettings Filterable { get; } = new GridFilterableSettings();

		/// <summary>
		/// Gets the keyboard navigation configuration.
		/// </summary>
		public GridSettings Navigatable { get; } = new GridSettings();

		/// <summary>
		/// Gets the scrolling configuration.
		/// </summary>
		public GridScrollableSettings Scrollable { get; } = new GridScrollableSettings();

		/// <summary>
		/// Gets the paging configuration.
		/// </summary>
		public PageableSettings Pageable { get; } = new PageableSettings();

		/// <summary>
		/// Gets the sorting configuration.
		/// </summary>
		/// <value>The sorting.</value>
		public GridSortableSettings Sortable { get; } = new GridSortableSettings();

		public GridGroupableSettings Grouping { get; } = new GridGroupableSettings();

		public GridSettings Resizable { get; } = new GridSettings();

		public GridSettings Reorderable { get; } = new GridSettings();

		/// <summary>
		/// Gets the columns of the grid.
		/// </summary>
		public IList<GridColumnBase<T>> Columns { get; } = new List<GridColumnBase<T>>();

		public IList<GridColumnBase<T>> VisibleColumns
		{
			get
			{
				return Columns.Where(c => c.Visible).ToList();
			}
		}

		public MobileMode Mobile
		{
			get;
			set;
		}

		public bool? AutoBind { get; set; }

		/// <summary>
		/// Gets or sets a value indicating whether custom binding is enabled.
		/// </summary>
		/// <value><c>true</c> if custom binding is enabled; otherwise, <c>false</c>. The default value is <c>false</c></value>
		public bool EnableCustomBinding { get; set; }

		protected override Dictionary<string, object> SerializeSettings()
		{
			var settings = base.SerializeSettings();

			var autoBind = DataSource.Type != DataSourceType.Server && AutoBind.GetValueOrDefault(true);
						
			var idPrefix = "#";
			if (IsInClientTemplate)
			{
				idPrefix = "\\" + idPrefix;
			}

			var columns = VisibleColumns.Select(c => c.ToJson());
			if (columns.Any())
			{
				settings["columns"] = columns;
			}

			if (Grouping.Enabled)
			{
				settings["groupable"] = Grouping.ToJson();
			}

			if (Pageable.Enabled)
			{
				Pageable.AutoBind = autoBind;

				settings["pageable"] = Pageable.ToJson();
			}

			if (Sortable.Enabled)
			{
				var sorting = Sortable.ToJson();
				settings["sortable"] = sorting.Any() ? (object)sorting : true;
			}

			if (Selectable.Enabled)
			{
				settings["selectable"] = $"{Selectable.Mode}, {Selectable.Type}";
			}

			if (Filterable.Enabled)
			{
				var filtering = Filterable.ToJson();
				settings["filterable"] = filtering.Any() ? (object)filtering : true;
			}

			if (ColumnMenu.Enabled)
			{
				var menu = ColumnMenu.ToJson();
				settings["columnMenu"] = menu.Any() ? (object)menu : true;
			}

			if (Resizable.Enabled)
			{
				settings["resizable"] = true;
			}

			if (ColumnResizeHandleWidth != DEFAULT_COLUMN_RESIZE_HANDLE_WIDTH)
			{
				settings["columnResizeHandleWidth"] = ColumnResizeHandleWidth;
			}

			if (Reorderable.Enabled)
			{
				settings["reorderable"] = true;
			}

			if (!Scrollable.Enabled)
			{
				settings["scrollable"] = false;
			}
			else
			{
				var scrolling = Scrollable.ToJson();
				if (scrolling.Any())
				{
					settings["scrollable"] = scrolling;
				}
				settings["height"] = Scrollable.Height;
			}

			if (Editable.Enabled)
			{
				settings["editable"] = Editable.ToJson();
			}

			if (ToolBar.Enabled)
			{
				settings["toolbar"] = ToolBar.ToJson().First().Value;
			}

			if (autoBind == false)
			{
				settings["autoBind"] = autoBind;
			}

			settings["dataSource"] = DataSource.ToJson();

			if (!String.IsNullOrEmpty(ClientDetailTemplateId))
			{
				settings["detailTemplate"] = new ClientHandlerDescriptor { HandlerName = String.Format("kendo.template(jQuery('{0}{1}').html())", idPrefix, ClientDetailTemplateId) };
			}

			if (!String.IsNullOrEmpty(ClientRowTemplate))
			{
				settings["rowTemplate"] = ClientRowTemplate;
			}

			if (!String.IsNullOrEmpty(ClientAltRowTemplate))
			{
				settings["altRowTemplate"] = ClientAltRowTemplate;
			}

			if (Navigatable.Enabled)
			{
				settings["navigatable"] = true;
			}

			if (Mobile != MobileMode.Disabled)
			{
				if (Mobile == MobileMode.Auto)
				{
					settings["mobile"] = true;
				}
				else
				{
					settings["mobile"] = Mobile.ToString().ToLowerInvariant();
				}
			}

			return settings;
		}

		private string EditorForModel(IHtmlHelper htmlHelper, string templateName, IEnumerable<Action<IDictionary<string, object>, object>> foreignKeyData, object additionalViewData)
		{
			var viewContext = ViewContext.ViewContextForType<T>(ModelMetadataProvider);
			((ICanHasViewContext)htmlHelper).Contextualize(viewContext);

			if (foreignKeyData != null)
			{
				var dataItem = Editable.DefaultDataItem();
				foreignKeyData.Each(action => action(viewContext.ViewData, dataItem));
			}

			if (templateName.HasValue())
			{
				return htmlHelper.EditorForModel(templateName, additionalViewData).ToString();
			}

			return htmlHelper.EditorForModel(additionalViewData).ToString();

		}

		private void InitializeEditors()
		{			
			var popupSlashes = new Regex("(?<=data-val-regex-pattern=\")([^\"]*)", RegexOptions.Multiline);

			var dataItem = Editable.DefaultDataItem();

			var htmlHelper = ViewContext.CreateHtmlHelper<T>();

			if (Editable.Mode != GridEditMode.InLine && Editable.Mode != GridEditMode.InCell)
			{
				var html = EditorForModel(htmlHelper, Editable.TemplateName, Columns.OfType<IGridForeignKeyColumn>().Select(c => c.SerializeSelectList), Editable.AdditionalViewData);

				EditorHtml = popupSlashes.Replace(html, match =>
				{
					return match.Groups[0].Value.Replace("\\", IsInClientTemplate ? "\\\\\\\\" : "\\\\");
				});
			}
			else
			{			
				var fields = DataSource.Schema.Model.Fields;

				var isDynamic = dataItem.GetType().IsDynamicObject();

				VisibleColumns.LeafColumns().OfType<IGridBoundColumn>().Each(column =>
				{
					var field = fields.FirstOrDefault(f => f.Member == column.Member);
					if (isDynamic && field != null && !field.IsEditable)
					{
						return;
					}																	
										
					var editorHtml = column.GetEditor(htmlHelper);

					if (IsInClientTemplate)
					{
						editorHtml = popupSlashes.Replace(editorHtml, match =>
						{
							return match.Groups[0].Value.Replace("\\", "\\\\");
						});
					}
					column.EditorHtml = editorHtml;

				});
			}			
		}
		public string EditorHtml { get; set; }

		private void ProcessDataSource()
		{
			if (Pageable.Enabled && DataSource.PageSize == 0)
			{
				DataSource.PageSize = 10;
			}

			var binder = new DataSourceRequestModelBinder();

			var bindingContext = new ModelBindingContext {
				ValueProvider = ActionBindingContext.Value.ValueProvider,
				ModelMetadata = ModelMetadataProvider.GetMetadataForType(null, typeof(T))
			};

			var result = binder.BindModelAsync(bindingContext).Result; // make it run synchronously

			DataSource.Process((DataSourceRequest)bindingContext.Model, !EnableCustomBinding);					
		}

		protected override void WriteHtml(TextWriter writer)
		{
			if (!Columns.Any() && AutoGenerateColumns)
			{
				foreach (GridColumnBase<T> column in new GridColumnGenerator<T>(this).GetColumns())
				{
					Columns.Add(column);
				}
			}

			if (!HtmlAttributes.ContainsKey("id"))
			{
				HtmlAttributes["id"] = Id;

			}

			if (DataSource.Type != DataSourceType.Custom || DataSource.CustomType == "aspnetmvc-ajax")
			{
				ProcessDataSource();
			}

			if (Editable.Enabled)
			{
				InitializeEditors();
			}

			var tag = Generator.GenerateTag("div", ViewContext, Id, Name, HtmlAttributes);

			writer.Write(tag.ToString());

			base.WriteHtml(writer);
		}
	}
}